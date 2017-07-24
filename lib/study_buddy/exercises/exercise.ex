defmodule StudyBuddy.Exercises.Exercise do
  use Ecto.Schema
  import Ecto.Changeset
  alias StudyBuddy.Exercises.Exercise


  schema "exercises_exercises" do
    field :type, :string
    field :task, :string
    field :answer, :string
    field :time_limit, :integer
    field :reviews, :integer, default: 0
    field :successes, :integer, default: 0
    field :failures, :integer, default: 0
    field :is_due?, :boolean, default: true
    field :last_review, :utc_datetime
    field :next_review, :utc_datetime, default: DateTime.utc_now()
    field :source, :string
    field :mastered?, :boolean, default: false
    belongs_to :user, StudyBuddy.Accounts.User
    belongs_to :topic, StudyBuddy.Categories.Topic

    timestamps()
  end

  @doc false
  def changeset(%Exercise{} = exercise, attrs) do
    exercise
    |> cast(attrs, [:type, :task, :answer, :time_limit, :reviews, :successes, :failures, :next_review, :source])
    |> validate_required([:type, :task, :next_review])
  end
end
