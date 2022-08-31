defmodule DAppWeb.Schema.SemesterType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: DApp.Repo
  import_types(Absinthe.Type.Custom)

  #---------------------Semester Object------------------------
  object :semester_type do
    field :code, :string
    field(:program, :program_type, resolve: assoc(:program))
  end

  #---------------------These Are Semester Input Types------------------------
  input_object :get_semesters_by_program_input_type do
    field :program_name, :string
  end
  input_object :create_semester_input_type do
    field :code, :string
    field :program_name, :string
  end
  input_object :update_semester_input_type do
    field :code, :string
    field :program_name, :string
  end
  input_object :delete_semester_input_type do
    field :code, :string
    field :program_name, :string
  end
end