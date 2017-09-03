defmodule StudyBuddyWeb.SessionController do
  use StudyBuddyWeb, :controller

  action_fallback StudyBuddyWeb.FallbackController

  def create(conn, %{"username" => username, "password" => password}) do
    with {:ok, conn} <- StudyBuddy.Auth.login_by_username_and_pass(conn, username, password, repo: StudyBuddy.Repo) do
      new_conn = Guardian.Plug.api_sign_in(conn, conn.assigns[:current_user])
      jwt = Guardian.Plug.current_token(new_conn)
      {:ok, claims} = Guardian.Plug.claims(new_conn)
      expiration = Map.get(claims, "exp")

      ## Cleanup, debuggin only
      require Logger
      Logger.debug "Current resource: #{inspect(Guardian.Plug.current_resource(new_conn))}"

      new_conn
      |> put_resp_header("authorization", "Bearer #{jwt}")
      |> put_resp_header("x-expires", "#{expiration}")
      |> render("login.json", jwt: jwt)
    end
  end
end
