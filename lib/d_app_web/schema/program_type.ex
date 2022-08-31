defmodule DAppWeb.Schema.ProgramType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: DApp.Repo

  #---------------------Program Object------------------------
  object :program_type do
    field :id, :string
    field :duration, :string
  end

  #---------------------These Are Program Input Types------------------------
  input_object :create_program_input_type do
    field :id, :string
    field :duration, :string
  end
  input_object :update_program_input_type do
    field :id, :string
    field :duration, :string
  end
  input_object :delete_program_input_type do
    field :id, :string
  end
end