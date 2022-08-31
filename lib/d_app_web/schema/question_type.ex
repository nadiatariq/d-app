defmodule DAppWeb.Schema.QuestionType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: DApp.Repo

  object :question_type do
    field :question, :string
    field :options, :map
  end
end