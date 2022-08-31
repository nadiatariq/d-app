defmodule DApp.Repo.Migrations.CreateExamResults do
  use Ecto.Migration

  def change do
    create table(:exam_results) do

      add :marks, :float

      add :exam_id, references(:exams)
      add :user_id, references(:users)
      add :course_id, references(:courses)
      timestamps()
    end

    create index(:exam_results, [:exam_id, :user_id, :course_id])
  end
end
