defmodule DAppWeb.Schema.QuizType do
  import DAppWeb.Schema.{UserType}
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: DApp.Repo

  object :quiz_type do
    field(:user, :user_type, resolve: assoc(:users))
  end
end