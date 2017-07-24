defmodule StudyBuddy.ExerciseTest do
  use StudyBuddy.DataCase

  alias StudyBuddy.Exercises

  describe "exercise" do

    @valid_attrs %{
      type: "flashcard",
      task: "Answer this question!",
      answer: "The answer is 42.",
      time_limit: 30_000,
      source: "A great and informative resource book."
     }

     def exercise_fixture(attrs \\ %{}) do
       {:ok, exercise} =
         attrs
         |> Enum.into(@valid_attrs)
         |> Exercises.create_exercise()

       exercise
     end

  end
end
