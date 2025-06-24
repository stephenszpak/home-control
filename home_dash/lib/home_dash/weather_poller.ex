defmodule HomeDash.WeatherPoller do
  use GenServer

  @topic "weather"

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state) do
    schedule_poll()
    {:ok, state}
  end

  def handle_info(:poll, state) do
    poll()
    schedule_poll()
    {:noreply, state}
  end

  def poll(req_fun \\ &Req.get/1) do
    with {:ok, url} <- build_url() do
      case req_fun.(url) do
        {:ok, %{status: 200, body: body}} ->
          Phoenix.PubSub.broadcast(HomeDash.PubSub, @topic, {:weather_update, body})
          {:ok, body}
        {:ok, %{status: code}} when code >= 400 -> {:error, code}
        {:error, reason} -> {:error, reason}
      end
    end
  end

  defp schedule_poll do
    Process.send_after(self(), :poll, 60_000)
  end

  defp build_url do
    api_key = Application.get_env(:home_dash, __MODULE__)[:api_key]
    lat = Application.get_env(:home_dash, __MODULE__)[:lat]
    lon = Application.get_env(:home_dash, __MODULE__)[:lon]
    if api_key && lat && lon do
      {:ok, "https://api.openweathermap.org/data/3.0/onecall?lat=#{lat}&lon=#{lon}&appid=#{api_key}&units=metric"}
    else
      {:error, :config}
    end
  end
end
