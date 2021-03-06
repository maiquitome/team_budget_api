defmodule TeamBudgetWeb.Graphql.Types.Team do
  @moduledoc """
  Graphql Team Type.
  """

  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  import AbsintheErrorPayload.Payload
  payload_object(:team_payload, :team)

  alias TeamBudget.Teams.Data.Team
  alias TeamBudgetWeb.Graphql.Middlewares.{Authorize, Log}
  alias TeamBudgetWeb.Graphql.Resolvers.Team, as: TeamResolver

  object :team do
    field :id, non_null(:uuid4)
    field :name, non_null(:string)
    field :description, non_null(:string)
    field :slug, non_null(:string)
    field :user_id, non_null(:uuid4)
    field :total_budget, :string

    field :user, :user, resolve: dataloader(Team)
    field :projects, list_of(:project), resolve: dataloader(Team)
  end

  input_object :team_input do
    field :name, non_null(:string)
    field :description, non_null(:string)
  end

  object :team_queries do
    @desc "Gets all teams by user_id"
    field :teams_by_user, list_of(:team) do
      arg :user_id, non_null(:uuid4)
      middleware(Authorize, :user)
      resolve &TeamResolver.get_all_teams_by_user_id/2
      middleware(Log)
    end

    @desc "Gets all teams of the logged in user"
    field :teams, list_of(:team) do
      middleware(Authorize, :user)
      resolve &TeamResolver.get_all_teams/3
      middleware(Log)
    end
  end
end
