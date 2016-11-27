defmodule CongressNinja.SlugService do
  alias CongressNinja.SlugAdjective
  alias CongressNinja.SlugService
  alias CongressNinja.SlugNoun
  alias CongressNinja.RepRequest

  def generate do
    new_slug = "#{SlugAdjective.sample.adjective}-#{SlugNoun.sample.noun}"
    case RepRequest.find_by_slug(new_slug) do
      nil ->
        new_slug
      _ ->
        SlugService.generate
    end
  end
end
