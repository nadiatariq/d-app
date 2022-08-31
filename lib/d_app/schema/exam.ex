defmodule DApp.Schema.Exam do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exams" do

    timestamps()
  end

  @doc false
  def changeset(exam, attrs) do
    exam
    |> cast(attrs, [])
    |> validate_required([])
  end
end
