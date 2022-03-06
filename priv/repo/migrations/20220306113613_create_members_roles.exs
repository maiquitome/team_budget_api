defmodule TeamBudget.Repo.Migrations.CreateMembersRoles do
  use Ecto.Migration

  def change do
    create table(:members_roles, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :member_id,
          references(:members, on_delete: :delete_all, on_update: :update_all, type: :binary_id)

      add :role_id,
          references(:roles, on_delete: :delete_all, on_update: :update_all, type: :binary_id)

      timestamps()
    end

    create index(:members_roles, [:member_id])
    create index(:members_roles, [:role_id])
  end
end
