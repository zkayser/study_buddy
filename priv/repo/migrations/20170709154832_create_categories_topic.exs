defmodule StudyBuddy.Repo.Migrations.CreateStudyBuddy.Categories.Topic do
  use Ecto.Migration

  def change do
    create table(:categories_topics) do
      add :title, :string
      add :category_id, references(:categories_categories)

      timestamps()
    end

  end
end
