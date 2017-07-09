defmodule StudyBuddy.Repo.Migrations.AddIsDueAndLastReviewToExercises do
  use Ecto.Migration

  def change do
    alter table(:exercises_exercises) do
      add :is_due?, :boolean
      add :last_review, :utc_datetime
    end
  end
end
