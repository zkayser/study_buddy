defmodule StudyBuddyWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use StudyBuddyWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(StudyBuddyWeb.ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found, _}) do
    conn
    |> put_status(:not_found)
    |> render(StudyBuddyWeb.ErrorView, :"404")
  end

  def call(conn, {:error, :unauthorized, _}) do
    conn
    |> put_status(401)
    |> render(StudyBuddyWeb.ErrorView, :"401")
  end

  def call(conn, _) do
    conn
    |> put_status(500)
    |> render(StudyBuddyWeb.ErrorView, :"500")
  end
end
