defmodule TeamBudgetWeb.Graphql.Resolvers.Project do
  @moduledoc """
  Project Resolver.
  """
  alias TeamBudget.Projects
  alias TeamBudget.Teams.Data.Team

  def create_project(_parent, %{input: %{} = project}, %{context: %{team: %Team{id: team_id}}}) do
    project
    |> Map.put(:team_id, team_id)
    |> Projects.create_project()
  end

  def update_project(_parent, %{project: %{} = project, id: id}, _) do
    Projects.update_project(project, id)
  end

  def delete_project(_parent, %{id: id}, _) do
    Projects.delete_project(id)
  end

  def list_projects(_parent, _, %{context: %{team: %Team{id: team_id}}}) do
    {:ok, Projects.list_projects(team_id)}
  end
end
