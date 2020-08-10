# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :reproduce,
  ecto_repos: [Reproduce.Repo]

# Configures the endpoint
config :reproduce, ReproduceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8QPoeoc1bNftDszXEYLO35Y3KPCjB5pM38XNOt6/yY6MUf3PJp/a5kTE3fcX5W2q",
  render_errors: [view: ReproduceWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Reproduce.PubSub,
  live_view: [signing_salt: "1fU4ijF0"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
