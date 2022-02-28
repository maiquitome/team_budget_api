defmodule TeamBudgetWeb.Graphql.Types do
  @moduledoc """
  Types Module
  """
  use Absinthe.Schema.Notation

  alias TeamBudgetWeb.Graphql.Types

  import_types Absinthe.Type.Custom

  import_types AbsintheErrorPayload.ValidationMessageTypes

  import_types Types.Custom.UUID4
  import_types Types.User
end
