alias TeamBudget.{Accounts.Data.User, Repo}

%{
  first_name: "Maiqui",
  last_name: "",
  email: "maiqui@email.com",
  password: "123456",
  password_confirmation: "123456"
}
|> User.changeset()
|> Repo.insert!()
