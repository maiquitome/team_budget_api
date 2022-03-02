defmodule TeamBudgetWeb.Graphql.Resolvers.Team do
  @moduledoc """
  User Resolver.
  """
  alias TeamBudget.Teams
  alias TeamBudget.Accounts.Data.User

  def get_all_teams_by_user_id(%{user_id: user_id}, _resolution) do
    Teams.get_all_teams_by_user_id(user_id)
  end

  def get_all_teams(
        _parent,
        _params,
        %{
          context: %{
            current_user: {
              :ok,
              %User{id: id_of_the_logged_in_user}
            }
          }
        }
      ) do
    Teams.get_all_teams_by_user_id(id_of_the_logged_in_user)
  end
end
