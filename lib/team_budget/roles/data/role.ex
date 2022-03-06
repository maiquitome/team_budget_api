defmodule TeamBudget.Roles.Data.Role do
  @moduledoc """
  Role Schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Core.Utils

  alias TeamBudget.{
    Members.Data.Member,
    MembersRoles.Data.MembersRoles,
    PermissionRole.Data.PermissionRole,
    Permissions.Data.Permission,
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "roles" do
    field :description, :string
    field :name, :string
    field :slug, :string

    many_to_many :permissions, Permission, join_through: PermissionRole, on_replace: :delete
    many_to_many :members, Member, join_through: MembersRoles, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :slug, :description])
    |> validate_required([:name, :description])
    |> Utils.create_slug(:name)
    |> unique_constraint(:slug)
    |> unique_constraint(:name)
  end

  def insert_permissions(%__MODULE__{} = role, [%Permission{} | _] = permissions) do
    role
    |> cast(%{}, [])
    |> put_assoc(:permissions, permissions)
  end
end
