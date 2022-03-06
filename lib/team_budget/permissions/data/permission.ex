defmodule TeamBudget.Permissions.Data.Permission do
  @moduledoc """
  Permission Schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Core.Utils

  alias TeamBudget.{
    PermissionRole.Data.PermissionRole,
    Roles.Data.Role
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "permissions" do
    field :description, :string
    field :name, :string
    field :slug, :string

    many_to_many :roles, Role, join_through: PermissionRole, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(permission, attrs) do
    permission
    |> cast(attrs, [:name, :slug, :description])
    |> validate_required([:name, :description])
    |> Utils.create_slug(:name)
    |> unique_constraint(:slug)
    |> unique_constraint(:name)
  end
end
