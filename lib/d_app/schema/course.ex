defmodule DApp.Schema.Course do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "courses" do
    field :course_code, :string
    field :title, :string
    field :credit_hours, :float

    belongs_to(:semester, DApp.Schema.Semester)
    belongs_to(:program, DApp.Schema.Program, type: :string)

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:course_code, :title, :semester_id, :credit_hours, :program_id])
    |> validate_required([:course_code, :title, :credit_hours, :semester_id, :program_id])
  end
end
