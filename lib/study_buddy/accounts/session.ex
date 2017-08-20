defmodule StudyBuddy.Accounts.Session do
  use Ecto.Schema
  import Ecto.Changeset
  alias StudyBuddy.Accounts.Session
  alias StudyBuddy.Repo
  alias StudyBuddy.Accounts.User

  embedded_schema do
    field :jwt, :string
  end

  def new(jwt), do: %Session{jwt: jwt}
end
