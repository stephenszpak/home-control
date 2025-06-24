import Config

if config_env() == :prod do
  config :home_dash, HomeDash.Repo,
    database: System.get_env("DATABASE_PATH") || "./data/home_dash_prod.db",
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "5"),
    journal_mode: :wal,
    busy_timeout: 60_000

  config :home_dash, HomeDashWeb.Endpoint,
    http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")],
    url: [host: System.get_env("PHX_HOST") || "example.com", port: 80],
    secret_key_base: System.fetch_env!("SECRET_KEY_BASE")

  config :home_dash, HomeDash.WeatherPoller,
    api_key: System.get_env("OPENWEATHER_API_KEY"),
    lat: System.get_env("OPENWEATHER_LAT"),
    lon: System.get_env("OPENWEATHER_LON")
end
