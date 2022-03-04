defmodule TeamBudget.Members.Core.UserIsMemberFromATeam do
  @moduledoc """
  Checks if the user belongs to a team.
  """
  import Ecto.Query
  alias TeamBudget.{Members.Data.Member, Repo}

  def call(user_id, team_id) when is_binary(user_id) and is_binary(team_id) do
    query =
      from(m in Member,
        where: m.user_id == ^user_id and m.team_id == ^team_id,
        select: count(m.id)
      )

    [count] = Repo.all(query)

    count > 0
  end
end
