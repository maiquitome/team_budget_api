defmodule Core.Utils.Slug.Create do
  @moduledoc """
  Create Slug.
  """

  alias Ecto.Changeset

  def call(%Changeset{changes: changes} = changeset, field) when is_atom(field) do
    slug =
      changes
      |> Map.get(field)
      |> Slug.slugify()

    changes = Map.put(changes, :slug, slug)

    %Changeset{changeset | changes: changes}
  end
end
