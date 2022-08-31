defmodule DApp.Schema.TeacherCourse do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teacher_courses" do

    belongs_to(:course, DApp.Schema.Course)
    belongs_to(:user, DApp.Schema.User)
    timestamps()
  end

  @doc false
  def changeset(teacher_course, attrs) do
    teacher_course
    |> cast(attrs, [:course_id, :user_id])
    |> validate_required([])
  end
end
