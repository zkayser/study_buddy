defmodule JwtExample.User do
  use JwtExample.Web, :model

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps
  end

  @required_fields ~w(email password)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:email, min: 3, max: 30)
  end

  def registration_changeset(model, params) do
      model
      |> changeset(params)
      |> cast(params, ~w(password), [])
      |> validate_length(:password, min: 4, max: 50)
      |> put_pass_hash()
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
