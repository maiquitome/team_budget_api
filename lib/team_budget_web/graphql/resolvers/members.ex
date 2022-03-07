defmodule TeamBudgetWeb.Graphql.Resolvers.Member do
  @moduledoc """
  Member Resolver.
  """
  alias TeamBudget.Members

  def list_members(_parent, %{team_id: team_id}, _) do
    {:ok, Members.list_members(team_id)}
  end
end
