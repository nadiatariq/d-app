defmodule DApp.Schema.Semester do
  use Ecto.Schema
  import Ecto.Changeset

  schema "semesters" do
    field :code, :string
    belongs_to(:program, DApp.Schema.Program, type: :string)
    timestamps()
  end

  @doc """
  This Is default changeset for semesters.
  """
  def changeset(semester, attrs) do
    semester
    |> cast(attrs, [:program_id, :code])
    |> validate_required([:program_id, :code])
  end
end
