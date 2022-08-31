defmodule DApp.Schema.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "answers" do
    field :answer, :string

    belongs_to(:question, DApp.Schema.Question)
    belongs_to(:user, DApp.Schema.User)

    timestamps()
  end

  @doc false
  def changeset(options, attrs) do
    options
    |> cast(attrs, [:answer])
    |> validate_required([])
  end
end
