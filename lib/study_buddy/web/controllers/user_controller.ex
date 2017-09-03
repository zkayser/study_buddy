defmodule StudyBuddyWeb.UserController do
  require Logger
  use StudyBuddyWeb, :controller
  plug Guardian.Plug.EnsureAuthenticated, [handler: __MODULE__] when action in [:show, :update, :delete, :edit]

  alias StudyBuddy.Accounts
  alias StudyBuddy.Accounts.{User}

  action_fallback StudyBuddyWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.register_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    Logger.debug "In UserController.show with #{id}"
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def unauthenticated(conn, params) do
      Logger.warn "Unauthenticated request made to UserController.\nParams: #{inspect params}"
      conn
      |> redirect(to: "/")
  end
end
