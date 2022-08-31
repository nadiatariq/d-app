defmodule DApp.Repo.Migrations.CreateExamTypes do
  use Ecto.Migration

  def change do
    create table(:exam_types, primary_key: false) do
      add :id, :string, primary_key: true

      timestamps()
    end
  end
end
