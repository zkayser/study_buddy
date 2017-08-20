defmodule StudyBuddyWeb.TopicControllerTest do
  use StudyBuddyWeb.ConnCase

  alias StudyBuddy.Categories
  # alias StudyBuddy.Categories.Topic

  @create_attrs %{title: "some title"}
  # @update_attrs %{title: "some updated title"}
  # @invalid_attrs %{title: nil}

  def fixture(:topic) do
    {:ok, topic} = Categories.create_topic(@create_attrs)
    topic
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end
end
