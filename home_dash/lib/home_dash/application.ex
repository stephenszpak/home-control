defmodule HomeDash.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    children = [
      HomeDash.Repo,
      {Phoenix.PubSub, name: HomeDash.PubSub},
      HomeDashWeb.Endpoint,
      {Oban, oban_config()},
      {Registry, keys: :unique, name: HomeDash.TimerRegistry.Registry},
      HomeDash.TimerRegistry,
      HomeDash.WeatherPoller
    ]

    opts = [strategy: :one_for_one, name: HomeDash.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    HomeDashWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp oban_config do
    Application.get_env(:home_dash, Oban)
  end
end
