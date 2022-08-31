defmodule DApp.Schema.ExamType do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "exam_types" do
    field :id, :string, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(exam_type, attrs) do
    exam_type
    |> cast(attrs, [:id])
    |> validate_required([:id])
  end
end
