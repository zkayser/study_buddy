defmodule StudyBuddy.Repo.Migrations.AddUserReferenceToCategories do
  use Ecto.Migration

  def change do
    alter table(:categories_categories) do
      add :user_id, references(:accounts_and_users)
    end
  end
end
