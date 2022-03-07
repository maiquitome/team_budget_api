defmodule TeamBudgetWeb.Graphql.Types.Member do
  @moduledoc """
  Member Type.
  """

  use Absinthe.Schema.Notation

  alias TeamBudgetWeb.Graphql.Middlewares.{Authorize, Log}
  alias TeamBudgetWeb.Graphql.Resolvers.Member, as: MemberResolver

  object :member do
    field :id, :uuid4
    field :user_id, :uuid4
    field :team_id, :uuid4
    field :user, :user
    field :team, :team
    field :roles, list_of(:role)
    field :permissions, list_of(:permission)
  end

  object :member_queries do
    @desc "Get list of all members of a Team"
    field :members, list_of(:member) do
      arg(:team_id, non_null(:uuid4))
      middleware(Authorize, :user)
      resolve(&MemberResolver.list_members/3)
      middleware(Log)
    end
  end
end
