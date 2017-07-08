defmodule StudyBuddy.Accounts.Registration do
  use Ecto.Schema
  import Ecto.Changeset
  alias StudyBuddy.Repo
  alias StudyBuddy.Accounts.{Registration, User}

  embedded_schema do
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password, :string
    field :password_hash, :string
  end

  def changeset(%Registration{} = registration, params) do
    registration
    |> cast(params, [:username, :first_name, :last_name, :email, :password])
    |> validate_required([:username, :email, :password])
    |> validate_format(:email, ~r/(\w+)@([\w.]+)/)
    |> put_pass_hash()
  end

  def register_user(attrs \\ %{}) do
    changeset(%Registration{}, attrs)
    |> to_user
    |> User.changeset(%{})
    |> Repo.insert()
  end

  def to_user(%Ecto.Changeset{valid?: true} = changeset) do
    registration = Ecto.Changeset.apply_changes(changeset)
    user = %User{}
    |> Map.put(:username, registration.username)
    |> Map.put(:email, registration.email)
    |> Map.put(:password_hash, registration.password_hash)

    cond do
      registration.first_name != nil && registration.last_name != nil ->
        Map.put(user, :name, registration.first_name <> " " <> registration.last_name)
      registration.first_name != nil ->
        Map.put(user, :name, registration.first_name)
      registration.last_name != nil ->
        Map.put(user, :name, registration.last_name)
      true -> user
    end
  end

  def to_user(%Ecto.Changeset{valid?: false} = changeset) do
    changeset
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
