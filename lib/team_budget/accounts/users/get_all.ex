defmodule TeamBudget.Accounts.Users.GetAll do
  @moduledoc """
  Module to fetch the user list.
  """

  alias TeamBudget.{Accounts.User, Repo}

  def call do
    Repo.all(User)
  end
end
