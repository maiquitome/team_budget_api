defmodule TeamBudget.PermissionRole.Data.PermissionRole do
  @moduledoc """
  PermissionRole Schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias TeamBudget.Permissions.Data.Permission
  alias TeamBudget.Roles.Data.Role

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "permission_role" do
    belongs_to :permissions, Permission
    belongs_to :roles, Role

    timestamps()
  end

  @doc false
  def changeset(permission_role, attrs) do
    permission_role
    |> cast(attrs, [])
    |> validate_required([])
  end
end
