defmodule TeamBudgetWeb.Graphql.Middlewares.SetATeam do
  @moduledoc """
  SetATeam
  """
  @behaviour Absinthe.Middleware

  alias Absinthe.Resolution

  def call(resolution, _params) do
    if Map.get(resolution.context, :team) |> is_nil do
      Resolution.put_result(resolution, {:error, "Please choose a valid slug team"})
    else
      resolution
    end
  end
end
