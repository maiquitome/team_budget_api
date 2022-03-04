defmodule TeamBudget.Accounts do
  @moduledoc """
  Accounts Facade.
  """

  alias TeamBudget.Accounts.Users.Create, as: UserCreate
  alias TeamBudget.Accounts.Users.GetAll, as: UserGetAll
  alias TeamBudget.Accounts.Users.GetByEmail, as: UserGetByEmail
  alias TeamBudget.Accounts.Users.GetById, as: UserGetById

  defdelegate create_user(attrs), to: UserCreate, as: :call
  defdelegate get_all_users(), to: UserGetAll, as: :call
  defdelegate get_user_by_email(email), to: UserGetByEmail, as: :call
  defdelegate get_user_by_id(id), to: UserGetById, as: :call
end
