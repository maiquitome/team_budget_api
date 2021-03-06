defmodule TeamBudget.Repo.Migrations.CreatePermissions do
  use Ecto.Migration

  def change do
    create table(:permissions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :slug, :string, null: false
      add :description, :string, null: false

      timestamps()
    end

    create unique_index(:permissions, [:slug])
    create unique_index(:permissions, [:name])
  end
end
