defmodule TeamBudgetWeb.Graphql.Types.Permission do
  @moduledoc """
  Permission Type.
  """
  use Absinthe.Schema.Notation

  import AbsintheErrorPayload.Payload
  payload_object(:permission_payload, :permission)

  alias TeamBudgetWeb.Graphql.Middlewares.{Authorize, Log}
  alias TeamBudgetWeb.Graphql.Resolvers.Permission, as: PermissionResolver

  object :permission do
    field :id, :string
    field :description, :string
    field :name, :string
    field :slug, :string
  end

  input_object :permission_input do
    field :description, non_null(:string)
    field :name, non_null(:string)
  end

  object :permission_queries do
    @desc "List Permissions"
    field :permissions, list_of(:permission) do
      middleware(Authorize, :user)
      resolve(&PermissionResolver.list_permissions/3)
    end
  end

  object :permission_mutation do
    @desc "Create a Permission"
    field :create_permission, :permission_payload do
      arg(:input, non_null(:permission_input))
      middleware(Authorize, :admin)
      resolve(&PermissionResolver.create_permission/3)
      middleware(&build_payload/2)
      middleware(Log)
    end
  end
end
