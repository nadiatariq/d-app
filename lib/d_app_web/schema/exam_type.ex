defmodule DAppWeb.Schema.ExamType do
  import DAppWeb.Schema.{UserType, CourseType}
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: DApp.Repo

  object :exams_type do
    field :name, :string
    field :start_date, :date
    field :start_time, :time

    field(:exam_type, :exam_type_type, resolve: assoc(:exam_types))
  end

  object :exam_type_type do
    field :id, :string
  end

  object :exam_result_type do
    field :marks, :string

    field(:exam_type, :exam_type_type, resolve: assoc(:exam_types))
    field(:user, :user_type, resolve: assoc(:users))
    field(:course, :course_type, resolve: assoc(:courses))
  end
end