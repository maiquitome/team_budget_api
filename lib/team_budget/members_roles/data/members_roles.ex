defmodule TeamBudget.MembersRoles.Data.MembersRoles do
  @moduledoc """
  MembersRoles
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias TeamBudget.{
    Members.Data.Member,
    Roles.Data.Role
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "members_roles" do

    belongs_to :member, Member
    belongs_to :role, Role

    timestamps()
  end

  @doc false
  def changeset(members_roles, attrs) do
    members_roles
    |> cast(attrs, [])
    |> validate_required([])
  end
end
