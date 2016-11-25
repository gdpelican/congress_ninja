defmodule CongressNinja.RootController do
  use CongressNinja.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
