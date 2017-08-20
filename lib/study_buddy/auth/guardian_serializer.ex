defmodule StudyBuddy.GuardianSerializer do
  alias StudyBuddy.Accounts.User
  alias StudyBuddy.Repo

  def for_token(%User{} = user), do: {:ok, "User:#{user.id}"}
  def for_token(_), do: :error

  def from_token("User:" <> id), do: {:ok, Repo.get(User, id)}
  def from_token(_), do: :error
end
