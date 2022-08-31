defmodule DApp.Repo.Migrations.CreateSemesters do
  use Ecto.Migration

  def change do
    create table(:semesters) do
      add :code, :string
      add :program_id, references(:programs, on_delete: :delete_all, type: :varchar)
      timestamps()
    end
    create index(:semesters, [:program_id])
  end
end
