defmodule TeamBudgetWeb.Graphql.Types.Project do
  @moduledoc """
  Graphql Project Type.
  """
  use Absinthe.Schema.Notation

  object :project do
    field :id, :uuid4
    field :budget, :string
    field :description, :string
    field :name, :string
    field :slug, :string
  end
end
