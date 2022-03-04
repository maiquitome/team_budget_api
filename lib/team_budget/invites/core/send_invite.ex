defmodule TeamBudget.Invites.Core.SendInvite do
  @moduledoc """
  Send Invite.
  """
  alias TeamBudget.Invites

  def call(emails, current_user, team) do
    {:ok, _invites} = invites = Invites.create_invite(emails, current_user, team)

    Invites.send_email(invites)

    {:ok, _invites} = invites
  end
end
