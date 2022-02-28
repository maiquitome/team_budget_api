defmodule TeamBudgetWeb.Graphql.Middlewares.Log do
  @moduledoc """
  Middleware Log.
  """
  require Logger

  @behaviour Absinthe.Middleware

  @filter_string "[FILTERED]"
  @replacements [
    {~r/password_hash: ".*"/, "password_hash: #{@filter_string}"}
  ]

  def call(resolution, _) when is_struct(resolution) do
    resolution
    |> log_message()
    |> filter_info()
    |> Logger.debug()

    resolution
  end

  defp log_message(%Absinthe.Resolution{value: value})
       when is_struct(value)
       when is_list(value)
       when is_nil(value) do
    "Resolution value #{inspect(value)}"
  end

  defp filter_info(log = acc) when is_binary(log) do
    Enum.reduce(@replacements, acc, fn {regex, replacement}, acc ->
      String.replace(acc, regex, replacement)
    end)
  end
end
