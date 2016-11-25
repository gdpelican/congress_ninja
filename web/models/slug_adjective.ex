defmodule CongressNinja.SlugAdjective do
  use CongressNinja.Web, :model
  alias CongressNinja.Repo
  alias CongressNinja.SlugAdjective

  schema "slug_adjectives" do
    field :adjective
  end

  def sample do
    Repo.all(from a in SlugAdjective, order_by: fragment("RANDOM()"))
    |> List.first
  end
end
