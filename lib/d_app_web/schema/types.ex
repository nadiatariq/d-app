defmodule DAppWeb.Schema.Types do
  use Absinthe.Schema.Notation
  alias DAppWeb.Schema

  import_types(Absinthe.Plug.Types)
  import_types(Schema.UserType)
  import_types(Schema.CourseType)
#  import_types(Schema.QuizType)
  import_types(Schema.ProgramType)
  import_types(Schema.SemesterType)
#  import_types(Schema.QuestionType)
end
