defmodule TeamBudget.Teams do
  @moduledoc """
  Teams Facade.
  """

  alias TeamBudget.Teams.Core.GetAllByUserId, as: GetAllByUserId
  alias TeamBudget.Teams.Core.GetAll, as: GetAll

  defdelegate get_all_teams_by_user_id(user_id), to: GetAllByUserId, as: :call
  defdelegate get_all_teams(), to: GetAll, as: :call
end
