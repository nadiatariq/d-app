defmodule DAppWeb.Schema.CourseType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: DApp.Repo

  #---------------------Courses Object------------------------
  object :course_type do
    field :course_code, :string
    field :title, :string
    field :credit_hours, :float
    field(:program, :program_type, resolve: assoc(:program))
    field(:semester, :semester_type, resolve: assoc(:semester))
  end

  #---------------------These Are Courses Input Types------------------------
  input_object :create_course_input_type do
    field :course_code, :string
    field :title, :string
    field :credit_hours, :float
    field :program_name, :string
    field :semester_code, :string
  end
  input_object :update_course_input_type do
    field :course_code, :string
    field :title, :string
    field :credit_hours, :float
    field :program_name, :string
    field :semester_code, :string
  end
  input_object :delete_course_input_type do
    field :course_code, :string
    field :program_name, :string
    field :semester_code, :string
  end
end