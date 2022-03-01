defmodule TeamBudget.Accounts.Users.GetByEmail do
  @moduledoc """
  Get user by email.
  """

  alias Ecto.Schema
  alias TeamBudget.{Accounts.User, Repo}

  @doc """
  ## Examples

      iex> alias TeamBudget.Accounts.{User, Users.Create, Users.GetByEmail}
      ...>
      ...> params = %{
      ...>  first_name: "Maiqui",
      ...>  last_name: "",
      ...>  email: "maiqui@email.com",
      ...>  password: "123456",
      ...>  password_confirmation: "123456"
      ...> }
      ...>
      ...> {:ok, %User{role: "user"}} = Create.call params
      ...>
      ...> {:ok, %User{}} = GetByEmail.call "maiqui@email.com"
      ...>
      ...> GetByEmail.call "maiqui@email"
      {:error, "User not found. Please check email."}

  """
  @spec call(binary()) :: {:ok, Schema.t()} | {:error, String.t()}
  def call(email) when is_binary(email) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, "User not found. Please check email."}
      user_schema -> {:ok, user_schema}
    end
  end

  def call(_) do
    {:error, "Email must be of type binary."}
  end
end
