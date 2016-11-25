defmodule CongressNinja.RepRequestView do
  use CongressNinja.Web, :view
  alias CongressNinja.Rep
  alias CongressNinja.Repo

  def render("error.json", errors) do
    errors
  end
end
