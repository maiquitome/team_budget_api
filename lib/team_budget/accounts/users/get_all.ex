defmodule TeamBudget.Accounts.Users.GetAll do
  @moduledoc """
  Module to fetch the user list.
  """

  alias TeamBudget.{Accounts.Data.User, Repo}

  def call do
    {:ok, Repo.all(User)}
  end
end
