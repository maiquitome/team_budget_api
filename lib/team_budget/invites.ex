defmodule TeamBudget.Invites do
  @moduledoc """
  Invites Facade.
  """
  alias TeamBudget.Invites.Core.{CreateInvite, SendInvite}
  alias TeamBudget.Invites.Server.SendEmail

  defdelegate create_invite(invites, current_user, team), to: CreateInvite, as: :call
  defdelegate send_invite(invites, current_user, team), to: SendInvite, as: :call
  defdelegate send_email(invites), to: SendEmail, as: :call
end
