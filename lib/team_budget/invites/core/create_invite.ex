defmodule TeamBudget.Invites.Core.CreateInvite do
  @moduledoc """
  Creates Invite.
  """

  alias TeamBudget.{
    Accounts,
    Invites.Data.Invite,
    Members,
    Members.Data.Member,
    Repo
  }

  def call(invites, current_user, team) do
    invites =
      invites
      |> create_payload_to_each_invite(current_user, team)
      |> prepare_invites_to_store_into_database()
      |> store_invites()
      |> build_response()

    {:ok, invites}
  end

  defp create_payload_to_each_invite(invites, current_user, team) do
    Enum.map(invites, fn invite ->
      # user_invited = Accounts.get_user_by_email(invite)

      user_invited =
        case Accounts.get_user_by_email(invite) do
          {:error, _message} -> nil
          {:ok, user} -> user
        end

      invite = %Invite{
        email: invite,
        user_id: current_user.id,
        team_id: team.id,
        email_has_account: (user_invited != nil && true) || false
      }

      {user_invited, invite}
    end)
  end

  defp prepare_invites_to_store_into_database(invites) do
    Enum.reduce(invites, Ecto.Multi.new(), fn {user, invite}, multi ->
      prepare_transaction_for_each_invite(user, multi, invite)
    end)
  end

  defp prepare_transaction_for_each_invite(nil, multi, invite) do
    Ecto.Multi.insert(multi, "invite:#{invite.email}", invite)
  end

  defp prepare_transaction_for_each_invite(user, multi, invite) do
    if Members.user_is_member_from_a_team?(user.id, invite.team_id) do
      multi
    else
      multi
      |> Ecto.Multi.insert("associate_user_team:#{user.id}-#{invite.email}", %Member{
        user_id: user.id,
        team_id: invite.team_id
      })
      |> Ecto.Multi.insert("invite:#{invite.email}", invite)
    end
  end

  defp store_invites(transaction) do
    Repo.transaction(transaction)
  end

  defp build_response({:ok, result}) do
    result
    |> Map.to_list()
    |> Enum.filter(fn {operation, _} -> String.contains?(operation, "invite:") end)
    |> Enum.map(fn {_, invite} -> Repo.preload(invite, [:user, :team]) end)
  end
end
