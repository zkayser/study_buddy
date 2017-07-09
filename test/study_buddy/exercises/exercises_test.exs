defmodule StudyBuddy.ExercisesTest do
  use StudyBuddy.DataCase

  alias StudyBuddy.Exercises

  describe "exercises" do
    # alias StudyBuddy.Exercises.Exercise

    @valid_attrs %{}
    # @update_attrs %{}
    # @invalid_attrs %{}

    def exercise_fixture(attrs \\ %{}) do
      {:ok, exercise} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Exercises.create_exercise()

      exercise
    end
  end
end
