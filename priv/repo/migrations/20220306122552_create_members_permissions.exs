defmodule TeamBudget.Repo.Migrations.CreateMembersPermissions do
  use Ecto.Migration

  def change do
    create table(:members_permissions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :member_id, references(:members, on_delete: :nothing, type: :binary_id)
      add :permission_id, references(:permissions, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:members_permissions, [:member_id])
    create index(:members_permissions, [:permission_id])
  end
end
