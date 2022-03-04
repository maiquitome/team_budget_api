defmodule TeamBudgetWeb.Graphql.Types.Invite do
  @moduledoc """
  Graphql Invite Type.
  """
  use Absinthe.Schema.Notation

  alias TeamBudgetWeb.Graphql.Middlewares.{Authorize, Log, SetATeam}
  alias TeamBudgetWeb.Graphql.Resolvers.Invite, as: InviteResolver

  object :invite do
    field :id, :string
    field :team_id, :string
    field :user_id, :string
    field :email, :string
    field :email_has_account, :boolean
  end

  object :invite_mutation do
    @desc "Send an Invite"
    field :send_invite, list_of(:invite) do
      arg(:invites, non_null(list_of(:string)))
      middleware(Authorize, :user)
      middleware(SetATeam)
      resolve(&InviteResolver.send_invite/3)
      middleware(Log)
    end
  end
end
