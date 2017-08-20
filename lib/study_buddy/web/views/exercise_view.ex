defmodule StudyBuddyWeb.ExerciseView do
  use StudyBuddyWeb, :view
  alias StudyBuddyWeb.ExerciseView

  def render("index.json", %{exercises: exercises}) do
    %{data: render_many(exercises, ExerciseView, "exercise.json")}
  end

  def render("show.json", %{exercise: exercise}) do
    %{data: render_one(exercise, ExerciseView, "exercise.json")}
  end

  def render("exercise.json", %{exercise: exercise}) do
    %{id: exercise.id}
  end
end
