use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :study_buddy, StudyBuddyWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :study_buddy, StudyBuddy.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "zkayser",
  password: System.get_env("POSTGRES"),
  database: "study_buddy_test",
  hostname: "localhost",
  template: "template0",
  pool: Ecto.Adapters.SQL.Sandbox
