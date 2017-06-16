defmodule StudyBuddy.Repo.Migrations.AddPassWordHashToAccountsUsers do
  use Ecto.Migration

  def change do
    alter table(:accounts_and_users) do
      add :password_hash, :string
    end
  end
end
