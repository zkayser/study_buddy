defmodule StudyBuddyWeb.CategoryController do
  use StudyBuddyWeb, :controller
  require Logger
  plug Guardian.Plug.EnsureAuthenticated, [handler: __MODULE__]

  alias StudyBuddy.Categories
  alias StudyBuddy.Categories.Category
  alias StudyBuddy.Accounts.User

  action_fallback StudyBuddyWeb.FallbackController

  def index(conn, _params) do
    categories = 
      conn
      |> Guardian.Plug.current_resource()
      |> Map.get(:id)
      |> Categories.list_categories()
    render(conn, "index.json", categories: categories)
  end

  def create(conn, %{"category" => category_params}) do
    user_id = Guardian.Plug.current_resource(conn).id
    with {:ok, %Category{} = category, %User{} = user} <- 
      Categories.create_category(category_params, user_id) 
    do
      conn
      |> put_status(:created)
      |> put_resp_header("location", category_path(conn, :show, category))
      |> render("show.json", category: category)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Categories.get_category!(id)
    render(conn, "show.json", category: category)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Categories.get_category!(id)

    with {:ok, %Category{} = category} <- Categories.update_category(category, category_params) do
      render(conn, "show.json", category: category)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Categories.get_category!(id)
    with {:ok, %Category{}} <- Categories.delete_category(category) do
      send_resp(conn, :no_content, "")
    end
  end

  def unauthenticated(conn, params) do
    Logger.warn "Unauthenticated request made to #{__MODULE__} with params: #{inspect params}"
    conn
    |> redirect(to: "/")
  end
end
