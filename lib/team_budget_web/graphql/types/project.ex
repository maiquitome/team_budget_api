defmodule TeamBudgetWeb.Graphql.Types.Project do
  @moduledoc """
  Graphql Project Type.
  """
  use Absinthe.Schema.Notation

  import AbsintheErrorPayload.Payload
  payload_object(:project_payload, :project)

  alias TeamBudgetWeb.Graphql.Middlewares.{Authorize, Log, SetATeam}
  alias TeamBudgetWeb.Graphql.Resolvers.Project, as: ProjectResolver

  object :project do
    field :id, :uuid4
    field :budget, :decimal
    field :description, :string
    field :name, :string
    field :slug, :string
    field :team_id, :uuid4
  end

  input_object :project_input do
    field :budget, non_null(:decimal)
    field :description, non_null(:string)
    field :name, non_null(:string)
  end

  object :project_queries do
    @desc "List Projects"
    field :projects, list_of(:project) do
      middleware(Authorize, :user)
      middleware(SetATeam)
      resolve(&ProjectResolver.list_projects/3)
    end
  end

  object :project_mutation do
    @desc "Create a Project"
    field :create_project, :project_payload do
      arg(:input, non_null(:project_input))
      middleware(Authorize, :user)
      middleware(SetATeam)
      resolve(&ProjectResolver.create_project/3)
      middleware(&build_payload/2)
      middleware(Log)
    end

    @desc "Update a Project"
    field :update_project, :project_payload do
      arg(:project, non_null(:project_input))
      arg(:id, non_null(:uuid4))
      middleware(Authorize, :user)
      resolve(&ProjectResolver.update_project/3)
      middleware(&build_payload/2)
    end

    @desc "Delete a Project"
    field :delete_project, :project_payload do
      arg(:id, non_null(:uuid4))
      middleware(Authorize, :user)
      resolve(&ProjectResolver.delete_project/3)
      middleware(&build_payload/2)
    end
  end
end
