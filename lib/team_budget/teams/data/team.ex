defmodule TeamBudget.Teams.Data.Team do
  @moduledoc """
  Team Struct.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Core.Utils

  alias TeamBudget.{
    Accounts.Data.User,
    Invites.Data.Invite,
    Members.Data.Member,
    Projects.Data.Project
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "teams" do
    field :description, :string
    field :name, :string
    field :slug, :string

    belongs_to :user, User

    has_many :projects, Project

    many_to_many :members, User, join_through: Member, on_replace: :delete
    many_to_many :invites, User, join_through: Invite, on_replace: :delete

    timestamps()
  end

  def data, do: Dataloader.Ecto.new(TeamBudget.Repo, query: &query/2)

  def query(queryable, _params), do: queryable

  def changeset(attrs \\ %{}) do
    changeset(%__MODULE__{}, attrs)
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :slug, :description, :user_id])
    |> validate_required([:name, :description])
    |> Utils.create_slug(:name)
    |> unique_constraint(:slug)
    |> unique_constraint(:name)
    |> cast_assoc(:projects, with: &Project.changeset/2)
  end
end
