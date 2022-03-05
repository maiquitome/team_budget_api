defmodule TeamBudgetWeb.Graphql.Types.Role do
  @moduledoc """
  Graphql Project Role.
  """
  use Absinthe.Schema.Notation

  import AbsintheErrorPayload.Payload
  payload_object(:role_payload, :role)

  alias TeamBudgetWeb.Graphql.Middlewares.{Authorize, Log}
  alias TeamBudgetWeb.Graphql.Resolvers.Role, as: RoleResolver

  object :role do
    field :id, :uuid4
    field :description, :string
    field :name, :string
    field :slug, :string
  end

  input_object :role_input do
    field :description, non_null(:string)
    field :name, non_null(:string)
  end

  object :role_queries do
    @desc "List a Roles"
    field :roles, list_of(:role) do
      middleware(Authorize, :user)
      resolve(&RoleResolver.list_roles/3)
      middleware(Log)
    end
  end

  object :role_mutation do
    @desc "Create a Role"
    field :create_role, :role_payload do
      arg(:input, non_null(:role_input))
      middleware(Authorize, :admin)
      resolve(&RoleResolver.create_role/3)
      middleware(&build_payload/2)
      middleware(Log)
    end
  end
end
