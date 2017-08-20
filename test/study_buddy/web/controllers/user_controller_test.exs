defmodule StudyBuddyWeb.UserControllerTest do
  use StudyBuddyWeb.ConnCase

  alias StudyBuddy.Accounts
  # alias StudyBuddy.Accounts.User
  # alias StudyBuddy.Accounts.Registration
  
  @create_attrs %{email: "email@example.com", first_name: "first", last_name: "last", username: "username", password: "password"}
  # @update_attrs %{email: "some updated email", name: "some updated name", username: "some updated username"}
  # @invalid_attrs %{email: nil, name: nil, username: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.register_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    fixture(:user)
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end
  
  test "index returns a 200 response" do
    conn = build_conn()
    conn = get conn, "/users"
    assert json_response(conn, 200)
  end
  
  test "index should contain the correct user data" do
    conn = build_conn()
    conn = get conn, "/users"
    response = json_response(conn, 200)
    [data|_rest] = response["data"]
    assert data["username"] == "username"
    assert data["email"] == "email@example.com"
    assert data["name"] == "first last"
  end
end
