defmodule DApp.Schema.StudentCourse do
  use Ecto.Schema
  import Ecto.Changeset

  schema "student_courses" do

    belongs_to(:course, DApp.Schema.Course)
    belongs_to(:user, DApp.Schema.User)
    timestamps()
  end

  @doc false
  def changeset(student_course, attrs) do
    student_course
    |> cast(attrs, [:course_id, :user_id])
    |> validate_required([])
  end
end
