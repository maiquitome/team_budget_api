defmodule TeamBudgetWeb.Graphql.Resolvers.Auth do
  @moduledoc false

  alias TeamBudgetWeb.Auth.Guardian

  def login(%{input: credentials}, _context) do
    Guardian.authenticate(credentials)
  end
end
