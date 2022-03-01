defmodule Core.Utils do
  @moduledoc """
  Utils.
  """

  alias Core.Utils.Slug.Create, as: SlugCreate

  defdelegate create_slug(changeset, slug), to: SlugCreate, as: :call
end
