defmodule DApp.Repo.Migrations.CreatePrograms do
  use Ecto.Migration

  def change do
    create table(:programs, primary_key: false) do
      add :id, :string, primary_key: true
      add :duration, :string

      timestamps()
    end
  end
end
