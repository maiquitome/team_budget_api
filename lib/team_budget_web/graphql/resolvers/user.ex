defmodule TeamBudgetWeb.Graphql.Resolvers.User do
  @moduledoc """
  User Resolver.
  """
  alias TeamBudget.Accounts

  def get_all(_params, _context), do: Accounts.get_all_users()
  def create(%{input: params}, _context), do: Accounts.create_user(params)
end
