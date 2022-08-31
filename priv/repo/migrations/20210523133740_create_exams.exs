defmodule DApp.Repo.Migrations.CreateExams do
  use Ecto.Migration

  def change do
    create table(:exams) do

      add :type_id, references(:exam_types, type: :varchar)
      timestamps()
    end

  end
end
