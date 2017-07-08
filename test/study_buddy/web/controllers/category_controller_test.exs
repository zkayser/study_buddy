defmodule StudyBuddy.Web.CategoryControllerTest do
  use StudyBuddy.Web.ConnCase

  alias StudyBuddy.Categories
  alias StudyBuddy.Categories.Category

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:category) do
    {:ok, category} = Categories.create_category(@create_attrs)
    category
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, category_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates category and renders category when data is valid", %{conn: conn} do
    conn = post conn, category_path(conn, :create), category: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, category_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "name" => "some name"}
  end

  test "does not create category and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, category_path(conn, :create), category: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen category and renders category when data is valid", %{conn: conn} do
    %Category{id: id} = category = fixture(:category)
    conn = put conn, category_path(conn, :update, category), category: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, category_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "name" => "some updated name"}
  end

  test "does not update chosen category and renders errors when data is invalid", %{conn: conn} do
    category = fixture(:category)
    conn = put conn, category_path(conn, :update, category), category: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen category", %{conn: conn} do
    category = fixture(:category)
    conn = delete conn, category_path(conn, :delete, category)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, category_path(conn, :show, category)
    end
  end
end
