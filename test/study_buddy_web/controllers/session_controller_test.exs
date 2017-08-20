defmodule StudyBuddyWeb.SessionControllerTest do
  use StudyBuddyWeb.ConnCase

  alias StudyBuddy.Accounts

  @user_registration %{email: "good@example.com", first_name: "first", last_name: "last", password: "password", username: "user"}
  @create_attrs %{"username" => "user", "password" => "password"}

  def fixture(:session) do
    {:ok, session} = Accounts.create_session(@create_attrs)
    session
  end

  setup %{conn: conn} do
    {:ok, user} = Accounts.register_user(@user_registration)
    on_exit fn -> 
      Accounts.delete_user(user)
    end
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create session" do
    # test "renders session when data is valid", %{conn: conn} do
    #   conn = post conn, session_path(conn, :create), session: @create_attrs
    #   assert %{"id" => id} = json_response(conn, 201)["data"]
    # end

    # test "renders errors when data is invalid", %{conn: conn} do
    #   conn = post conn, session_path(conn, :create), session: @invalid_attrs
    #   assert json_response(conn, 422)["errors"] != %{}
    # end
  end
end
