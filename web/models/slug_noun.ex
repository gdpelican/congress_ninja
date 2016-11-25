defmodule CongressNinja.SlugNoun do
  use CongressNinja.Web, :model
  alias CongressNinja.Repo
  alias CongressNinja.SlugNoun

  schema "slug_nouns" do
    field :noun
  end

  def sample do
    Repo.all(from n in SlugNoun, order_by: fragment("RANDOM()"))
    |> List.first
  end
end
