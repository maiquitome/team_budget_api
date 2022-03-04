defmodule TeamBudget.Teams.Core.GetAllByUserId do
  @moduledoc """
  Get all teams.
  """
  import Ecto.Query

  alias TeamBudget.Repo
  alias TeamBudget.{Projects.Data.Project, Teams.Data.Team}

  def call(user_id) when is_binary(user_id) do
    query =
      from t in Team,
        left_join: p in Project,
        on: p.team_id == t.id,
        group_by: [t.id],
        where: t.user_id == ^user_id,
        select: %Team{t | total_budget: p.budget |> sum() |> coalesce("0")}

    {:ok, Repo.all(query)}
  end
end
