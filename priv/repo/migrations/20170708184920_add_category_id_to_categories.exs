defmodule StudyBuddy.Repo.Migrations.AddCategoryIdToCategories do
  use Ecto.Migration

  def change do
    alter table(:categories_categories) do
      add :category_id, references(:categories_categories)
    end
  end
end
