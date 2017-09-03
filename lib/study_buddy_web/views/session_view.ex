defmodule StudyBuddyWeb.SessionView do
  use StudyBuddyWeb, :view
  alias StudyBuddyWeb.SessionView

  def render("index.json", %{sessions: sessions}) do
    %{data: render_many(sessions, SessionView, "session.json")}
  end

  def render("show.json", %{session: session}) do
    %{data: render_one(session, SessionView, "session.json")}
  end

  def render("session.json", %{session: session}) do
    %{id: session.id}
  end

  def render("login.json", %{jwt: jwt}) do
    {:ok, %{"aud" => user}} = Guardian.decode_and_verify(jwt)
    require Logger
    Logger.debug "Rendering login results with #{inspect jwt} and #{inspect user}"
    %{jwt: jwt, id: String.last(user)}
  end
end
