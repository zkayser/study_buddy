defmodule StudyBuddyWeb.ExerciseController do
  use StudyBuddyWeb, :controller

  alias StudyBuddy.Exercises
  alias StudyBuddy.Exercises.Exercise

  action_fallback StudyBuddyWeb.FallbackController

  def index(conn, _params) do
    exercises = Exercises.list_exercises()
    render(conn, "index.json", exercises: exercises)
  end

  def create(conn, %{"exercise" => exercise_params}) do
    with {:ok, %Exercise{} = exercise} <- Exercises.create_exercise(exercise_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", exercise_path(conn, :show, exercise))
      |> render("show.json", exercise: exercise)
    end
  end

  def show(conn, %{"id" => id}) do
    exercise = Exercises.get_exercise!(id)
    render(conn, "show.json", exercise: exercise)
  end

  def update(conn, %{"id" => id, "exercise" => exercise_params}) do
    exercise = Exercises.get_exercise!(id)

    with {:ok, %Exercise{} = exercise} <- Exercises.update_exercise(exercise, exercise_params) do
      render(conn, "show.json", exercise: exercise)
    end
  end

  def delete(conn, %{"id" => id}) do
    exercise = Exercises.get_exercise!(id)
    with {:ok, %Exercise{}} <- Exercises.delete_exercise(exercise) do
      send_resp(conn, :no_content, "")
    end
  end
end
