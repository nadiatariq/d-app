defmodule DApp.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :course_code, :string
      add :title, :string
      add :credit_hours, :float

      add :semester_id, references(:semesters, on_delete: :delete_all)
      add :program_id, references(:programs, on_delete: :delete_all, type: :varchar)
      timestamps()
    end
    create index(:courses, [:semester_id, :program_id])
  end
end
