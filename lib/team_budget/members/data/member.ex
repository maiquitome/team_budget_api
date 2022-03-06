defmodule TeamBudget.Members.Data.Member do
  @moduledoc """
  Member Schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias TeamBudget.{
    Accounts.Data.User,
    MembersPermissions.Data.MembersPermissions,
    MembersRoles.Data.MembersRoles,
    Permissions.Data.Permission,
    Roles.Data.Role,
    Teams.Data.Team
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "members" do
    belongs_to :user, User
    belongs_to :team, Team

    many_to_many :roles, Role, join_through: MembersRoles, on_replace: :delete
    many_to_many :permissions, Permission, join_through: MembersPermissions, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%{} = attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(member, attrs) do
    member
    |> cast(attrs, [])
    |> validate_required([])
  end

  def insert_roles(%__MODULE__{} = member, [%Role{} | _] = roles) do
    member
    |> cast(%{}, [])
    |> put_assoc(:roles, roles)
  end

  def insert_permissions(%__MODULE__{} = member, [%Permission{} | _] = permissions) do
    member
    |> cast(%{}, [])
    |> put_assoc(:permissions, permissions)
  end
end
