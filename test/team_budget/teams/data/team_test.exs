defmodule TeamBudget.Teams.Data.TeamTest do
  use TeamBudget.DataCase, async: true

  import TeamBudget.Factory

  alias Ecto.Changeset
  alias TeamBudget.Teams.Data.Team

  describe "changeset/1" do
    test "changeset validated successfully" do
      insert(:user)

      team_params = build(:team_params)

      response = Team.changeset(team_params)

      assert %Changeset{
               action: nil,
               changes: %{
                 description: "description text example",
                 name: "name test",
                 slug: "name-test",
                 user_id: "b721fcad-e6e8-4e8f-910b-6911f2158b4a"
               },
               errors: [],
               data: %Team{},
               valid?: true
             } = response
    end
  end
end
