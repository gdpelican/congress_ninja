defmodule CongressNinja.RepresentativeView do
  use CongressNinja.Web, :view

  def render("show.json", %{representative: representative}) do
    %{
      representative: %{
        "name"     => representative.name,
        "phone"    => representative.phone,
        "state"    => representative.state,
        "district" => representative.district
      }
    }
  end
end
