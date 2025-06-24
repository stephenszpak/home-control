import Config

config :home_dash, HomeDash.Repo,
  database: Path.expand("../data/home_dash_dev.db", __DIR__),
  pool_size: 5,
  show_sensitive_data_on_connection_error: true,
  journal_mode: :wal,
  busy_timeout: 60_000

config :home_dash, HomeDashWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: String.duplicate("a", 64),
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:default, ~w(--watch)]}
  ]

config :home_dash, HomeDash.WeatherPoller,
  api_key: System.get_env("OPENWEATHER_API_KEY"),
  lat: System.get_env("OPENWEATHER_LAT"),
  lon: System.get_env("OPENWEATHER_LON")

config :logger, level: :debug

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime
