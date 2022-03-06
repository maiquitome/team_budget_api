defmodule TeamBudget.Members.Data.Member do
  @moduledoc """
  Member Schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias TeamBudget.{
    Accounts.Data.User,
    MembersRoles.Data.MembersRoles,
    Roles.Data.Role,
    Teams.Data.Team
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "members" do
    belongs_to :user, User
    belongs_to :team, Team

    many_to_many :roles, Role, join_through: MembersRoles, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [])
    |> validate_required([])
  end

  def insert_roles(%__MODULE__{} = member, [%Role{} | _] = roles) do
    member
    |> cast(%{}, ~w[name slug description]a)
    |> put_assoc(:roles, roles)
  end
end
