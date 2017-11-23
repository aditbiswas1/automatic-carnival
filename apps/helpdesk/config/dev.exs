use Mix.Config

# Configure your database
config :helpdesk, Helpdesk.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "helpdesk_dev",
  hostname: "localhost",
  pool_size: 10
