defmodule DApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :dob, :date
      add :email, :string
      add :password, :string

      add :role_id, references(:user_roles, type: :varchar)

      timestamps()
    end

    create unique_index(:users, [:email, :role_id])
    create index(:users, [:role_id])
  end
end
