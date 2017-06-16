defmodule StudyBuddy.Accounts.Registration do
  use Ecto.Schema
  import Ecto.Changeset
  alias StudyBuddy.Accounts.{Registration, User}
  
  embedded_schema do
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password, :string
  end
  
  def changeset(params) do
    %Registration{}
    |> cast(params, [:first_name, :last_name, :email, :password])
    |> validate_required([:username, :email, :password])
    |> put_pass_hash()
  end
  
  defp put_pass_hash(changeset) do
    IO.puts "TODO"
  end

end