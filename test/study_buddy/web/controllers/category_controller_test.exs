defmodule StudyBuddyWeb.CategoryControllerTest do
  use StudyBuddyWeb.ConnCase

  alias StudyBuddy.Categories

  @create_attrs %{name: "some name"}

  def fixture(:category) do
    {:ok, category} = Categories.create_category(@create_attrs)
    category
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

end
