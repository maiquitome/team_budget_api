defmodule TeamBudgetWeb.Graphql.Schema do
  @moduledoc """
  Schema Module
  """

  use Absinthe.Schema

  import_types TeamBudgetWeb.Graphql.Types

  query do
    import_fields :user_queries
  end

  # mutation do
  # end
end
