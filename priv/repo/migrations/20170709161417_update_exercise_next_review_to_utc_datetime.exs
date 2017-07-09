defmodule StudyBuddy.Repo.Migrations.UpdateExerciseNextReviewToUTCDatetime do
  use Ecto.Migration

  def change do
    alter table(:exercises_exercises) do
      remove :next_review
      add :next_review, :utc_datetime
    end
  end
end
