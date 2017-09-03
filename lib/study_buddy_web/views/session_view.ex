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
    %{jwt: jwt, id: getId(user)}
  end

  defp getId(user_string) when is_binary user_string do
    user_string
    |> String.split(":")
    |> Enum.drop(1)
    |> hd()
  end
end

