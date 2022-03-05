defmodule TeamBudget.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :slug, :string, null: false
      add :description, :string, null: false

      timestamps()
    end

    create unique_index(:roles, [:slug])
    create unique_index(:roles, [:name])
  end
end
