defmodule DAppWeb.Schema.AnswerType do
  import DAppWeb.Schema.{UserType, CourseType, QuestionType}
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: DApp.Repo

  object :classroom_type do
    field :answer, :string

    field(:user, :user_type, resolve: assoc(:users))
    field(:course, :course_type, resolve: assoc(:courses))
    field(:question, :question_type, resolve: assoc(:questions))
  end
end