defmodule TeamBudgetWeb.Graphql.Resolvers.Permission do
  @moduledoc """
  Permission Resolvers.
  """
  alias TeamBudget.Permissions

  def create_permission(_parent, %{input: %{} = permission}, _) do
    Permissions.create_permission(permission)
  end

  def list_permissions(_parent, _, _) do
    {:ok, Permissions.list_permissions()}
  end
end
