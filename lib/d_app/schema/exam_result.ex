defmodule DApp.Schema.ExamResult do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exam_results" do
    field :marks, :string

    belongs_to(:exam, DApp.Schema.ExamTypes)
    belongs_to(:user, DApp.Schema.Users)
    belongs_to(:course, DApp.Schema.Courses, type: :string)

    timestamps()
  end

  @doc false
  def changeset(exam__result, attrs) do
    exam__result
    |> cast(attrs, [:exam_id, :user_id, :course_id, :marks])
    |> validate_required([])
  end
end
