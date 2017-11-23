# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :helpdesk_web,
  namespace: HelpdeskWeb,
  ecto_repos: [Helpdesk.Repo]

# Configures the endpoint
config :helpdesk_web, HelpdeskWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RWL343aAnfJTqInf6TfiJVgMuVHRH6tm9BYcOxlGhoUC3XwZbVNMk5ycDBlMgWUR",
  render_errors: [view: HelpdeskWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: HelpdeskWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :helpdesk_web, :generators,
  context_app: :helpdesk

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
