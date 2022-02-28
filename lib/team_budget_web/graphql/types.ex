defmodule TeamBudgetWeb.Graphql.Types do
  @moduledoc """
  Types Module
  """
  use Absinthe.Schema.Notation

  import_types Absinthe.Type.Custom

  import_types AbsintheErrorPayload.ValidationMessageTypes
end
