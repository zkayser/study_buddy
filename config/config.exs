# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :study_buddy,
  ecto_repos: [StudyBuddy.Repo]

# Configures the endpoint
config :study_buddy, StudyBuddy.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "84/7MjGsCrjb+bzN6a1GlrvzRHH2kk1uikW3qjhum/EAGhgDSp0bKeWFZ693dBkp",
  render_errors: [view: StudyBuddy.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: StudyBuddy.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
