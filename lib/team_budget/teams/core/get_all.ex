defmodule TeamBudget.Teams.Core.GetAll do
  @moduledoc """
  Get all teams.
  """

  alias TeamBudget.Repo
  alias TeamBudget.Teams.Data.Team

  def call do
    {:ok, Repo.all(Team)}
  end
end
