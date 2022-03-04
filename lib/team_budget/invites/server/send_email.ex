defmodule TeamBudget.Invites.Server.SendEmail do
  @moduledoc """
  Send Email.
  """

  import Bamboo.Email
  alias TeamBudget.Mailer

  alias TeamBudget.Invites.Data.Invite

  def call({:ok, [%Invite{} | _] = invites}) do
    Enum.each(invites, &send_email/1)
    # |> IO.inspect(label: "INVITES :::::::::::::::: ")
  end

  defp send_email(%Invite{} = invite) do
    Task.async(fn ->
      new_email()
      |> from({"Elxpro TeamBudget", "adm@elxpro.com"})
      |> to(invite.email)
      |> subject("[ELXPRO TeamBudget] - You were invited to join to a team #{invite.team.slug}")
      |> create_email_based_if_user_has_account(invite, invite.email_has_account)
      |> Mailer.deliver_now()
      |> IO.inspect(label: "EMAIL :::::::::::::::: ")
    end)
  end

  defp create_email_based_if_user_has_account(%Bamboo.Email{} = email, %Invite{} = invite, false) do
    html_body(email, """
    You were invited to join to a Team called #{invite.team.name} - (#{invite.team.slug})
    by #{invite.user.email}
    <p>To create your account please use apis with GraphQl</p>
    """)
  end

  defp create_email_based_if_user_has_account(%Bamboo.Email{} = email, %Invite{} = invite, true) do
    html_body(email, """
    You were invited to join to a Team called #{invite.team.name} - (#{invite.team.slug})
    by #{invite.user.email}
    """)
  end
end
