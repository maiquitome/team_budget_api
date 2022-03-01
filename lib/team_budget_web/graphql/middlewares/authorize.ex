defmodule TeamBudgetWeb.Graphql.Middlewares.Authorize do
  @moduledoc """
  Authorize Middleware.
  """

  @behaviour Absinthe.Middleware

  def call(resolution, _role) when is_struct(resolution) do
    case resolution.context do
      %{current_user: _current_user} -> resolution
      _ -> Absinthe.Resolution.put_result(resolution, {:error, "unauthorized"})
    end
  end
end
