defmodule StudyBuddy.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias StudyBuddy.Accounts.User


  schema "accounts_and_users" do
    field :email, :string
    field :name, :string
    field :username, :string
    field :password_hash, :string
    has_many :categories, StudyBuddy.Categories.Category

    timestamps()
  end

  @doc false
  def changeset(%Ecto.Changeset{valid?: false} = changeset, _attrs) do
    changeset
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :name, :password_hash])
    |> validate_required([:username, :email, :password_hash])
    |> validate_length(:username, min: 2, max: 20)
  end
end
