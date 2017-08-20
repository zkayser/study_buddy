defmodule StudyBuddyWeb.PageController do
  use StudyBuddyWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
