defmodule TeamBudget.Accounts.Users.GetById do
  @moduledoc """
  Get a user by ID.
  """

  alias Ecto.Schema
  alias TeamBudget.{Accounts.User, Repo}

  @doc """
  ## Examples

      iex> alias TeamBudget.Accounts
      ...> alias TeamBudget.Accounts.{User, Users.GetById}
      ...>
      ...> params = %{
      ...>  first_name: "Maiqui",
      ...>  last_name: "",
      ...>  email: "maiqui@email.com",
      ...>  password: "123456",
      ...>  password_confirmation: "123456"
      ...> }
      ...>
      ...> {:ok, %User{id: user_id}} = Accounts.create_user(params)
      ...>
      ...> {:ok, %User{}} = GetById.call(user_id)

  """
  @spec call(id :: binary()) :: {:ok, Schema.t()} | {:error, String.t()}
  def call(id) when is_binary(id) do
    case Repo.get(User, id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
