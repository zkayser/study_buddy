defmodule StudyBuddy.Repo.Migrations.CreateStudyBuddy.Exercises.Exercise do
  use Ecto.Migration

  def change do
    create table(:exercises_exercises) do
      add :type, :string
      add :task, :string
      add :answer, :string
      add :time_limit, :integer
      add :reviews, :integer, default: 0
      add :successes, :integer, default: 0
      add :failures, :integer, default: 0
      add :next_review, :datetime
      add :source, :string
      add :user_id, references(:accounts_and_users)
      add :topic_id, references(:categories_topics)

      timestamps()
    end

  end
end
