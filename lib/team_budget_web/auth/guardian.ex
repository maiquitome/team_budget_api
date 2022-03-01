defmodule TeamBudgetWeb.Auth.Guardian do
  @moduledoc """
  Authenticate.
  """

  use Guardian, otp_app: :team_budget

  alias TeamBudget.Accounts
  alias TeamBudget.Accounts.User

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}
  def subject_for_token(_, _), do: {:error, "Unknown resource type"}

  def resource_from_claims(%{"sub" => id}), do: {:ok, Accounts.get_by_id(id)}
  def resource_from_claims(_claims), do: {:error, "Unknown resource type"}

  @spec verify(Guardian.Token.token()) :: {:ok, Guardian.Token.claims()} | {:error, any}
  def verify(token) do
    decode_and_verify(token)
  end

  @doc """
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
    ...>
    ...> alias TeamBudgetWeb.Auth.Guardian
    ...>
    ...> credentials = %{
    ...>  email: "maiqui@email.com",
    ...>  password: "123456"
    ...> }
    ...>
    ...> {:ok, %{token: _token, user: _user}} = Guardian.authenticate credentials
    ...>
    ...> credentials = %{
    ...>  email: "maiqui@email",
    ...>  password: "123456"
    ...> }
    ...> Guardian.authenticate credentials
    {:error, "User not found. Please check email."}
    ...> credentials = %{
    ...>  email: "maiqui@email.com",
    ...>  password: "123123"
    ...> }
    ...>
    ...> Guardian.authenticate credentials
    {:error, "invalid password"}

  """
  def authenticate(%{email: email, password: password}) do
    with {:ok, %User{} = user} <- Accounts.get_by_email(email),
         {:ok, %User{} = user} <- Argon2.check_pass(user, password),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, %{token: token, user: user}}
    end
  end

  def authenticate(_), do: {:error, "Invalid or missing params"}
end
