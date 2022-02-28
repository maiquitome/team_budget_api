defmodule TeamBudget.Accounts.Users.Create do
  @moduledoc """
  Module for user creation.
  """

  alias Ecto.{Changeset, Schema}
  alias TeamBudget.{Accounts.User, Repo}

  @type params :: %{
          first_name: String.t(),
          last_name: String.t(),
          email: String.t(),
          password: String.t(),
          password_confirmation: String.t()
        }

  @doc """
  inserts a user into the database.

  ## Examples

      iex> alias TeamBudget.Accounts.{User, Users.Create}
      ...>
      ...> params = %{
      ...>  first_name: "Maiqui",
      ...>  last_name: "",
      ...>  email: "maiqui@email.com",
      ...>  password: "123456",
      ...>  password_confirmation: "123456"
      ...> }
      ...>
      ...> {:ok, %User{}} = Create.call params

  """
  @spec call(params()) :: {:ok, Schema.t()} | {:error, Changeset.t()}
  def call(params) when is_map(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end
end
