defmodule CongressNinja.RepresentativeController do
  use CongressNinja.Web, :controller

  alias CongressNinja.Representative

  def show(conn, _params) do
    render conn, "show.json", representative: Repo.one(Representative)
  end
end
