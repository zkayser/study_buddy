defmodule StudyBuddyWeb.ExerciseControllerTest do
  use StudyBuddyWeb.ConnCase

  alias StudyBuddy.Exercises
  # alias StudyBuddy.Exercises.Exercise

  @create_attrs %{}
  # @update_attrs %{}
  # @invalid_attrs %{}

  def fixture(:exercise) do
    {:ok, exercise} = Exercises.create_exercise(@create_attrs)
    exercise
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end
end
