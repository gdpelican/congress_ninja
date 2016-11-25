defmodule CongressNinja.Router do
  use CongressNinja.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :static do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", CongressNinja do
    pipe_through :static
    get "/", RootController, :index
    get "/:id", RepRequestController, :show
  end

  scope "/api", CongressNinja do
    pipe_through :api
    resources "/rep_requests", RepRequestController, only: [:show, :create, :update]
  end
end
