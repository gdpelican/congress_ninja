defmodule CongressNinja.Router do
  use CongressNinja.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CongressNinja do
    pipe_through :api

    resources "/representatives", RepresentativeController, only: [:show]
  end
end
