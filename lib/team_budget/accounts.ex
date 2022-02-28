defmodule TeamBudget.Accounts do
  @moduledoc """
  Accounts Facade.
  """

  alias TeamBudget.Accounts.Users.Create, as: UserCreate
  alias TeamBudget.Accounts.Users.GetAll, as: UserGetAll

  defdelegate create_user(attrs), to: UserCreate, as: :call
  defdelegate get_all_users(), to: UserGetAll, as: :call
end
