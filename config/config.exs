# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :d_app,
  ecto_repos: [DApp.Repo]

# Configures the endpoint
config :d_app, DAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WMqu/gxIfFoeA+lddgJ/luO44FibDdCZ8yenvvbc7jkIrl418bxNB0b3FtoGwL5n",
  render_errors: [view: DAppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DApp.PubSub,
  live_view: [signing_salt: "3CezEAKj"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Swagger Configuration
config :d_app, :phoenix_swagger,
       swagger_files: %{
         "priv/static/swagger.json" => [
           # phoenix routes will be converted to swagger paths
           router: DAppWeb.Router
         ]
       }

# Guardian Configuration
config :d_app, DApp.Auth.Guardian,
       issuer: "DApp",
       secret_key: "8xNJQr8TbnxDJlpy6ZPzOxQKsF45Qr/VFfw2UwLIZ/rAJkkL91mEma4q/KQQmJyt"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
