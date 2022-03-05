defmodule TeamBudgetWeb.Graphql.Schema do
  @moduledoc """
  Schema Module
  """
  use Absinthe.Schema

  alias TeamBudget.Teams.Data.Team

  import_types TeamBudgetWeb.Graphql.Types

  query do
    import_fields :user_queries
    import_fields :team_queries
    import_fields :project_queries
  end

  mutation do
    import_fields :user_mutation
    import_fields :auth_mutation
    import_fields :invite_mutation
    import_fields :project_mutation
  end

  def context(context) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Team, Team.data())

    Map.put(context, :loader, loader)
  end

  def plugins, do: [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
end
