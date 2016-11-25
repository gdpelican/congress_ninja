defmodule CongressNinja.SlugService do
  alias CongressNinja.SlugAdjective
  alias CongressNinja.SlugNoun

  def generate do
    "#{SlugAdjective.sample.adjective}-#{SlugNoun.sample.noun}"
  end
end
