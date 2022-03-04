defmodule TeamBudget.Invites.Data.Invite do
  @moduledoc """
  Invite Schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias TeamBudget.{Teams.Data.Team, Users.Data.User}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "invites" do
    field :email, :string
    field :email_has_account, :boolean, default: false
    belongs_to :user, User
    belongs_to :team, Team

    timestamps()
  end

  @doc false
  def changeset(invite, attrs) do
    invite
    |> cast(attrs, [:email, :email_has_account])
    |> validate_required([:email, :email_has_account])
  end
end