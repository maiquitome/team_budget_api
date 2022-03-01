defmodule TeamBudget.Team do
  use Ecto.Schema
  import Ecto.Changeset

  alias Core.Utils

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "teams" do
    field :description, :string
    field :name, :string
    field :slug, :string
    field :user_id, :binary_id

    timestamps()
  end

  def changeset(attrs \\ %{}) do
    changeset(%__MODULE__{}, attrs)
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :slug, :description])
    |> validate_required([:name, :description])
    |> Utils.create_slug(:name)
    |> unique_constraint(:slug)
    |> unique_constraint(:name)
  end
end
