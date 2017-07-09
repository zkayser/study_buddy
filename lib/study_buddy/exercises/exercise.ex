defmodule StudyBuddy.Exercises.Exercise do
  use Ecto.Schema
  import Ecto.Changeset
  alias StudyBuddy.Exercises.Exercise


  schema "exercises_exercises" do
    field :type
    field :task
    field :answer
    field :time_limit
    field :reviews
    field :successes
    field :failures
    field :next_review
    field :source
    belongs_to :user, StudyBuddy.Accounts.User
    belongs_to :topic, StudyBuddy.Categories.Topic

    timestamps()
  end

  @doc false
  def changeset(%Exercise{} = exercise, attrs) do
    exercise
    |> cast(attrs, [])
    |> validate_required([])
  end
end
