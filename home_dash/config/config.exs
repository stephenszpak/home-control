import Config

config :home_dash,
  ecto_repos: [HomeDash.Repo]

config :home_dash, HomeDashWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: HomeDashWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: HomeDash.PubSub,
  live_view: [signing_salt: "salt"]

config :esbuild,
  version: "0.7.1",
  default: [
    args: ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :tailwind,
  version: "3.3.3",
  default: [
    args: ~w(--config=tailwind.config.js --input=css/app.css --output=../priv/static/assets/app.css),
    cd: Path.expand("../assets", __DIR__)
  ]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
