defmodule TeamBudget.MembersPermissions.Data.MembersPermissions do
  @moduledoc """
  Members Permissions.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias TeamBudget.{
    Members.Data.Member,
    Permissions.Data.Permission
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "members_permissions" do
    belongs_to :member, Member
    belongs_to :permission, Permission

    timestamps()
  end

  @doc false
  def changeset(members_permissions, attrs) do
    members_permissions
    |> cast(attrs, [])
    |> validate_required([])
  end
end
