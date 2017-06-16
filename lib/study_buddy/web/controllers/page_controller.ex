defmodule StudyBuddy.Web.PageController do
  use StudyBuddy.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
