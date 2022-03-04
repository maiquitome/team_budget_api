defmodule TeamBudgetWeb.Graphql.Plugs.TeamContext do
  @moduledoc """
  TeamContext.
  """
  @behaviour Plug
  import Plug.Conn
  alias TeamBudget.Accounts.Data.User
  alias TeamBudget.Teams

  def init(opts), do: opts

  def call(conn, _) do
    case is_there_user_into_context?(conn) do
      nil ->
        Absinthe.Plug.put_options(conn, context: %{})

      current_user ->
        context =
          conn
          |> get_req_header("team")
          |> get_slug()
          |> get_team(current_user)

        Absinthe.Plug.put_options(conn, context: context)
    end
  end

  defp get_slug([]), do: nil
  defp get_slug([slug | _]), do: slug

  def get_team(nil, %User{} = current_user) do
    %{current_user: current_user}
  end

  def get_team(slug, %User{} = current_user) when is_binary(slug) do
    team = Teams.get_team_by_user_and_slug(current_user.id, slug)
    %{current_user: current_user, team: team}
  end

  defp is_there_user_into_context?(conn) do
    Map.get(conn.private[:absinthe].context, :current_user)
  end
end
