defmodule CongressNinja.RootView do
  use CongressNinja.Web, :view

  def render("index.html", _assigns) do
    render CongressNinja.RootView, "_vueapp.html"
  end
end
