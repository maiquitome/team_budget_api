defmodule TeamBudget.Members do
  @moduledoc """
  Members Facade.
  """
  alias TeamBudget.Members.Core.UserIsMemberFromATeam

  defdelegate user_is_member_from_a_team?(user_id, team_id), to: UserIsMemberFromATeam, as: :call
end
