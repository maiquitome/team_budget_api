defmodule TeamBudget.Teams.Core.GetTeamByUserAndSlug do
  @moduledoc """
  Get Team By User And Slug.
  """
  alias TeamBudget.Repo
  alias TeamBudget.Teams.Data.Team

  def call(user_id, slug) when is_binary(user_id) and is_binary(slug) do
    Repo.get_by(Team, slug: slug, user_id: user_id)
  end
end
