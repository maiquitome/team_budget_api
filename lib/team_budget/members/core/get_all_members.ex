defmodule TeamBudget.Members.Core.GetAllMembers do
  @moduledoc """
  List all members.
  """

  import Ecto.Query
  alias TeamBudget.{Members.Data.Member, Repo}

  def call(team_id) when is_binary(team_id) do
    query =
      from m in Member,
        where: m.team_id == ^team_id,
        preload: [:user, :team, :roles, :permissions]

    Repo.all(query)
  end
end
