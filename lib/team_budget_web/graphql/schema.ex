defmodule TeamBudgetWeb.Graphql.Schema do
  @moduledoc """
  Schema Module
  """
  use Absinthe.Schema

  alias TeamBudget.Teams.Data.Team

  import_types TeamBudgetWeb.Graphql.Types

  query do
    import_fields :member_queries
    import_fields :permission_queries
    import_fields :project_queries
    import_fields :role_queries
    import_fields :team_queries
    import_fields :user_queries
  end

  mutation do
    import_fields :auth_mutation
    import_fields :invite_mutation
    import_fields :permission_mutation
    import_fields :project_mutation
    import_fields :role_mutation
    import_fields :user_mutation
  end

  def context(context) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Team, Team.data())

    Map.put(context, :loader, loader)
  end

  def plugins, do: [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
end
