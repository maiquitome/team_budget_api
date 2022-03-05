defmodule Core.Utils.Slug.Create do
  @moduledoc """
  Create Slug.
  """

  alias Ecto.Changeset

  @spec call(changeset :: Changeset.t(), field :: atom()) :: Changeset.t()

  def call(%Changeset{changes: changes} = changeset, field) when is_atom(field) do
    case Map.get(changes, field) do
      nil ->
        changeset

      field_value ->
        slug = Slug.slugify(field_value)

        changes = Map.put(changes, :slug, slug)

        %Changeset{changeset | changes: changes}
    end
  end
end
