defmodule TeamBudgetWeb.Graphql.Resolvers.User do
  @moduledoc """
  User Resolver.
  """
  alias TeamBudget.Accounts

  def get_all(_params, _context), do: {:ok, Accounts.get_all_users()}
end
