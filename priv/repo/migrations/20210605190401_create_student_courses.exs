defmodule DApp.Repo.Migrations.CreateStudentCourses do
  use Ecto.Migration

  def change do
    create table(:student_courses) do

      add :course_id, references(:courses)
      add :user_id, references(:users)

      timestamps()
    end

    create index(:student_courses, [:user_id, :course_id])

  end
end
