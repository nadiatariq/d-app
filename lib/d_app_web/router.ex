defmodule DAppWeb.Router do
  use DAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {DAppWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
    plug DApp.Plugs.Context
  end

  pipeline :guardian do
    plug DApp.Auth.AuthAccessPipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/" do
    pipe_through :api

    forward("/graphql", Absinthe.Plug, schema: DApp.Schema)
    if Mix.env() == :dev do
      forward "/graphiql",
              Absinthe.Plug.GraphiQL,
              schema: DApp.Schema
      #       socket: DApp.UserSocket
    end
  end
end
