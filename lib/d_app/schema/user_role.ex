defmodule DApp.Schema.UserRole do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "user_roles" do
    field :id, :string, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(user_role, attrs) do
    user_role
    |> cast(attrs, [:id])
    |> validate_required([:id])
  end
end
