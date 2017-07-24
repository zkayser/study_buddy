defmodule StudyBuddy.ExercisesTest do
  use StudyBuddy.DataCase

  alias StudyBuddy.Exercises

  describe "exercises" do
    # alias StudyBuddy.Exercises.Exercise

    @valid_attrs %{
      type: "flashcard",
      task: "Answer this question!",
      answer: "The answer is 42.",
      time_limit: 30_000,
      source: "A great and informative resource book."
     }
    # @update_attrs %{}
    # @invalid_attrs %{}

    def exercise_fixture(attrs \\ %{}) do
      {:ok, exercise} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Exercises.create_exercise()

      exercise
    end

    test "should create an exercise with valid attributes" do
      assert exercise_fixture().task == @valid_attrs[:task]
    end

    test "exercises must have a type field to be valid" do
      {:error, changeset} = %{task: "Fill this in!", answer: "No.", time_limit: 30_000}
      |> Exercises.create_exercise()

      assert "can't be blank" in errors_on(changeset).type
      refute changeset.valid?
    end

    test "exercises must have a task to be valid" do
      {:error, changeset} = %{type: "flashcard", answer: "But you didn't even ask me a question!", time_limit: 30_000}
      |> Exercises.create_exercise()

      assert "can't be blank" in errors_on(changeset).task
      refute changeset.valid?
    end

  end
end
