defmodule TeamBudget.Factory do
  @moduledoc """
  Factory
  """
  use ExMachina.Ecto, repo: TeamBudget.Repo

  alias TeamBudget.Accounts.Data.User
  alias TeamBudget.Teams.Data.Team

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
      password_hash:
        "$argon2id$v=19$m=65536,t=8,p=2$O/5t8s4fy9LpgB4MEAUxGA$2/j83AwDID5FSFCtxy8qa3h5Rr/pC6/OKakL8N/ip7I"
    }
  end

  def team_params_factory do
    %{
      description: "description text example",
      name: "name test",
      user_id: "b721fcad-e6e8-4e8f-910b-6911f2158b4a"
    }
  end

  def team_factory do
    %Team{
      description: "description text example",
      name: "name test",
      slug: "name-test",
      user_id: "b721fcad-e6e8-4e8f-910b-6911f2158b4a",
      id: "47a476a1-1a5b-4460-9e30-357be4b9a7eb"
    }
  end
end
