alias TeamBudget.{
  Accounts.Data.User,
  Members.Data.Member,
  Permissions.Data.Permission,
  Repo,
  Roles.Data.Role
}

##########################
###### PERMISSIONS
##########################

send_invites =
  Permission.changeset(%Permission{}, %{
    name: "Send Invites",
    description: "Allows your to send invites to other people"
  })
  |> Repo.insert!()

create_project =
  Permission.changeset(%Permission{}, %{
    name: "Create Project",
    description: "Allows your to create projects"
  })
  |> Repo.insert!()

####################
###### ROLES
####################

admin =
  Role.changeset(%Role{}, %{
    name: "Admin",
    description: "Allows your to do everything"
  })
  |> Repo.insert!()
  |> Repo.preload(:permissions)
  |> Role.insert_permissions([create_project, send_invites])
  |> Repo.update!()

moderator =
  Role.changeset(%Role{}, %{
    name: "Moderator",
    description: "Allows your only create projects"
  })
  |> Repo.insert!()
  |> Repo.preload(:permissions)
  |> Role.insert_permissions([create_project])
  |> Repo.update!()

Role.changeset(%Role{}, %{
  name: "guest",
  description: "You can do nothing"
})
|> Repo.insert!()

####################
###### USERS
####################

{:ok, %{id: user_id, teams: [%{id: team_id} | _]}} =
  %{
    first_name: "Maiqui",
    last_name: "Tomé",
    email: "maiquitome@email.com",
    password: "123456",
    password_confirmation: "123456",
    teams: [
      %{
        name: "elxpro graphql",
        description: "learn more about graphql with this team",
        projects: [
          %{
            name: "graphQl api finance",
            description: "api to show assets durind the day",
            budget: Decimal.new("300000")
          },
          %{
            name: "liveview finance",
            description: "show assets durind the day",
            budget: Decimal.new("323002")
          }
        ]
      },
      %{
        name: "elxpro liveview",
        description: "learn more about graphql with this team"
      }
    ]
  }
  |> User.changeset()
  |> Repo.insert()

%Member{user_id: user_id, team_id: team_id}
|> Repo.insert!()

{:ok, _u2} =
  %{
    first_name: "Test2",
    last_name: "2Test",
    email: "t2@elxpro.com",
    password: "123456",
    password_confirmation: "123456"
  }
  |> User.changeset()
  |> Repo.insert()

{:ok, _u3} =
  %{
    first_name: "Test3",
    last_name: "3Test",
    email: "t3@elxpro.com",
    password: "123456",
    password_confirmation: "123456"
  }
  |> User.changeset()
  |> Repo.insert()
