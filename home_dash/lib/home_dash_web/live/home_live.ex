defmodule HomeDashWeb.HomeLive do
  use HomeDashWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Phoenix.PubSub.subscribe(HomeDash.PubSub, "weather")
    {:ok, assign(socket, weather: %{}, timers: %{}, system_time: DateTime.utc_now())}
  end

  @impl true
  def handle_info({:weather_update, data}, socket) do
    {:noreply, assign(socket, weather: data)}
  end

  @impl true
  def handle_info({:timer_tick, id, ms}, socket) do
    {:noreply, update(socket, :timers, &Map.put(&1, id, ms))}
  end

  @impl true
  def handle_info(:tick, socket) do
    Process.send_after(self(), :tick, 1000)
    {:noreply, assign(socket, system_time: DateTime.utc_now())}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="col-span-1 border p-2" id="weather">
      <h2>Weather</h2>
      <pre><%= inspect(@weather) %></pre>
    </div>
    <div class="col-span-1 border p-2">Upcoming Events</div>
    <div class="col-span-1 border p-2">Groceries</div>
    <div class="col-span-1 border p-2">
      <h2>Timers</h2>
      <pre><%= inspect(@timers) %></pre>
    </div>
    <div class="col-span-1 border p-2">
      <h2>System Time</h2>
      <%= @system_time %>
    </div>
    <div class="col-span-1 border p-2">Quick Actions</div>
    """
  end
end
