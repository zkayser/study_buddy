defmodule StudyBuddy.Web.TopicController do
  use StudyBuddy.Web, :controller

  alias StudyBuddy.Categories
  alias StudyBuddy.Categories.Topic

  action_fallback StudyBuddy.Web.FallbackController

  def index(conn, _params) do
    topics = Categories.list_topics()
    render(conn, "index.json", topics: topics)
  end

  def create(conn, %{"topic" => topic_params}) do
    with {:ok, %Topic{} = topic} <- Categories.create_topic(topic_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", topic_path(conn, :show, topic))
      |> render("show.json", topic: topic)
    end
  end

  def show(conn, %{"id" => id}) do
    topic = Categories.get_topic!(id)
    render(conn, "show.json", topic: topic)
  end

  def update(conn, %{"id" => id, "topic" => topic_params}) do
    topic = Categories.get_topic!(id)

    with {:ok, %Topic{} = topic} <- Categories.update_topic(topic, topic_params) do
      render(conn, "show.json", topic: topic)
    end
  end

  def delete(conn, %{"id" => id}) do
    topic = Categories.get_topic!(id)
    with {:ok, %Topic{}} <- Categories.delete_topic(topic) do
      send_resp(conn, :no_content, "")
    end
  end
end
