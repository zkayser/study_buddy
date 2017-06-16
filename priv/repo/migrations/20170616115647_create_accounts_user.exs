defmodule StudyBuddy.Repo.Migrations.CreateStudyBuddy.Accounts.User do
  use Ecto.Migration

  def change do
    create table(:accounts_and_users) do
      add :username, :string
      add :email, :string
      add :name, :string

      timestamps()
    end

  end
end
