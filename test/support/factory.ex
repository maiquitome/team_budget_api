defmodule TeamBudget.Factory do
  @moduledoc """
  Factory
  """
  use ExMachina.Ecto, repo: TeamBudget.Repo

  alias TeamBudget.Accounts.User

  def user_params_factory do
    %{
      first_name: "Maiqui",
      last_name: "",
      email: "maiqui@email.com",
      password: "123456",
      password_confirmation: "123456"
    }
  end

  def user_factory do
    %User{
      first_name: "Maiqui",
      last_name: "",
      email: "maiqui@email.com",
      password: nil,
      password_confirmation: nil,
      id: "b721fcad-e6e8-4e8f-910b-6911f2158b4a",
      password_hash: "$argon2id$v=19$m=65536,t=8,p=2$O/5t8s4fy9LpgB4MEAUxGA$2/j83AwDID5FSFCtxy8qa3h5Rr/pC6/OKakL8N/ip7I"
    }
  end
end
