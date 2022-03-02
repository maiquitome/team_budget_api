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

    field :user, :user, resolve: dataloader(Team)
  end

  input_object :team_input do
    field :name, non_null(:string)
    field :description, non_null(:string)
    # field :user_id, non_null(:uuid4)
  end

  object :team_queries do
    @desc "Gets all teams by user_id"
    field :teams_by_user, list_of(:team) do
      arg :user_id, non_null(:uuid4)
      middleware(Authorize, :team)
      resolve &TeamResolver.get_all_teams_by_user_id/2
      middleware(Log)
    end

    @desc "Gets all teams of the logged in user"
    field :teams, list_of(:team) do
      middleware(Authorize, :team)
      resolve &TeamResolver.get_all_teams/3
      middleware(Log)
    end
  end

  # object :team_mutation do
  #   @desc "Creates a new team"
  #   field :create_team, type: :team_payload do
  #     arg :input, non_null(:team_input)
  #     middleware(Authorize, :team)
  #     resolve &TeamResolver.create/2
  #     middleware(&build_payload/2)
  #     middleware(Log)
  #   end
  # end
end
