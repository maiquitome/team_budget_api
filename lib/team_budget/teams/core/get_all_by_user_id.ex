defmodule TeamBudget.Teams.Core.GetAllByUserId do
  @moduledoc """
  Get all teams.
  """
  import Ecto.Query

  alias TeamBudget.Repo
  alias TeamBudget.Teams.Data.Team

  def call(user_id) when is_binary(user_id) do
    query = from t in Team, where: t.user_id == ^user_id, select: t

    {:ok, Repo.all(query)}
  end
end
