import Config

config :home_dash, HomeDash.Repo,
  database: Path.expand("../data/home_dash_test.db", __DIR__),
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 5,
  journal_mode: :wal,
  busy_timeout: 60_000

config :home_dash, HomeDashWeb.Endpoint,
  http: [ip: {127,0,0,1}, port: 4002],
  secret_key_base: String.duplicate("a", 64),
  server: false

config :logger, level: :warning
