use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :moto_sol, MotoSolWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :moto_sol, MotoSol.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL_TEST"),
  pool: Ecto.Adapters.SQL.Sandbox
