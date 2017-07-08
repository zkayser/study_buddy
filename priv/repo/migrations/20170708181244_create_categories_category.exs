defmodule StudyBuddy.Repo.Migrations.CreateStudyBuddy.Categories.Category do
  use Ecto.Migration

  def change do
    create table(:categories_categories) do
      add :name, :string

      timestamps()
    end

  end
end
