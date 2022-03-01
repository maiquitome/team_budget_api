defmodule TeamBudget.Accounts.Data.UserTest do
  use TeamBudget.DataCase, async: true

  import TeamBudget.Factory

  alias Ecto.Changeset
  alias TeamBudget.Accounts.Data.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{
               action: nil,
               changes: %{
                 email: "maiqui@email.com",
                 first_name: "Maiqui",
                 password: "123456",
                 password_confirmation: "123456",
                 password_hash: _password_hash
               },
               errors: [],
               data: %User{},
               valid?: true
             } = response
    end
  end
end
