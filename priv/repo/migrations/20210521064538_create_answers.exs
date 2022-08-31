defmodule DApp.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :answer, :string

#      add :question_id, references(:questions)

      timestamps()
    end

#    create index(:answers, [:question_id])
  end
end
