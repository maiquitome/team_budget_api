defmodule TeamBudgetWeb.Graphql.Resolvers.Role do
  @moduledoc """
  Role Resolver.
  """
  alias TeamBudget.Roles

  def create_role(_parent, %{input: %{} = role}, _) do
    Roles.create_role(role)
  end

  def list_roles(_parent, _, _) do
    {:ok, Roles.list_roles()}
  end
end
