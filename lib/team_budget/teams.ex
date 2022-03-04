defmodule TeamBudget.Teams do
  @moduledoc """
  Teams Facade.
  """

  alias TeamBudget.Teams.Core.{
    GetAll,
    GetAllByUserId,
    GetTeamByUserAndSlug
  }

  defdelegate get_all_teams(), to: GetAll, as: :call
  defdelegate get_all_teams_by_user_id(user_id), to: GetAllByUserId, as: :call
  defdelegate get_team_by_user_and_slug(user_id, slug), to: GetTeamByUserAndSlug, as: :call
end
