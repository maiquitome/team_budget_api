defmodule TeamBudget.Members do
  @moduledoc """
  Members Facade.
  """
  alias TeamBudget.Members.Core.{GetAllMembers, UserIsMemberFromATeam}

  defdelegate user_is_member_from_a_team?(user_id, team_id), to: UserIsMemberFromATeam, as: :call
  defdelegate list_members(team_id), to: GetAllMembers, as: :call
end
