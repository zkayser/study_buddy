defmodule StudyBuddy.Repo.Migrations.AddMasteredToExercises do
  use Ecto.Migration

  def change do
    alter table(:exercises_exercises) do
      add :mastered?, :boolean
    end
  end
end
