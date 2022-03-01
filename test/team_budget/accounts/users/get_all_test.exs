defmodule TeamBudget.Accounts.Users.GetAllTest do
  use TeamBudget.DataCase, async: true
  doctest TeamBudget.Accounts.Users.GetAll

  import TeamBudget.Factory

  alias TeamBudget.Accounts.{Data.User, Users.GetAll}

  describe "call/0" do
    test "success" do
      insert(:user)
      insert(:user, %{id: "f2bf724b-d482-42d5-bd38-8a6a79c3934f", email: "maiqui2@email.com"})

      response = GetAll.call()

      assert {:ok,
              [
                %User{id: "b721fcad-e6e8-4e8f-910b-6911f2158b4a"},
                %User{id: "f2bf724b-d482-42d5-bd38-8a6a79c3934f"}
              ]} = response
    end
  end
end
