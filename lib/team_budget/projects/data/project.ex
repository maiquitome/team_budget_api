defmodule TeamBudget.Projects.Data.Project do
  @moduledoc """
  Project Schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Core.Utils
  alias TeamBudget.Teams.Data.Team

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "projects" do
    field :budget, :decimal
    field :description, :string
    field :name, :string
    field :slug, :string

    belongs_to :team, Team

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :description, :slug, :budget])
    |> validate_required([:name, :description, :budget])
    |> Utils.create_slug(:name)
    |> unique_constraint(:slug)
    |> unique_constraint(:name)
  end
end
