defmodule CongressNinja.Router do
  use CongressNinja.Web, :router

  pipeline :default do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", CongressNinja do
    pipe_through :default
    get "/",    RepRequestController, :index
    get "/:id", RepRequestController, :show
    resources "/rep_requests", RepRequestController, only: [:create, :update]
  end
end
