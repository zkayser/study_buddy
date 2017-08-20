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
config :study_buddy, StudyBuddyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "84/7MjGsCrjb+bzN6a1GlrvzRHH2kk1uikW3qjhum/EAGhgDSp0bKeWFZ693dBkp",
  render_errors: [view: StudyBuddyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: StudyBuddy.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["ES512"],
  secret_key: System.get_env("SB_SECRET"),
  issuer: "StudyBuddy",
  ttl: { 30, :days },
  serializer: StudyBuddy.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
