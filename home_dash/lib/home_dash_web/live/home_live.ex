defmodule HomeDashWeb.HomeLive do
  use HomeDashWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(HomeDash.PubSub, "weather")
      Phoenix.PubSub.subscribe(HomeDash.PubSub, "timers")
      Process.send_after(self(), :tick, 1000)
    end

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
    <div class="col-span-1 rounded-lg bg-white p-4 shadow" id="weather">
      <h2 class="text-lg font-semibold mb-2">Weather</h2>
      <%= if @weather == %{} do %>
        <p class="text-gray-500">Loading...</p>
      <% else %>
        <% temp = @weather["current"] && @weather["current"]["temp"] %>
        <% desc = @weather["current"] &&
                 (@weather["current"]["weather"] || [])
                 |> List.first()
                 |> Map.get("description") %>
        <p class="text-2xl font-bold"><%= temp %>°C</p>
        <p class="capitalize"><%= desc %></p>
      <% end %>
    </div>

    <div class="col-span-1 rounded-lg bg-white p-4 shadow">
      <h2 class="text-lg font-semibold mb-2">Upcoming Events</h2>
      <p class="text-gray-500">No events</p>
    </div>

    <div class="col-span-1 rounded-lg bg-white p-4 shadow">
      <h2 class="text-lg font-semibold mb-2">Groceries</h2>
      <p class="text-gray-500">No items</p>
    </div>

    <div class="col-span-1 rounded-lg bg-white p-4 shadow">
      <h2 class="text-lg font-semibold mb-2">Timers</h2>
      <pre class="text-sm"><%= inspect(@timers) %></pre>
    </div>

    <div class="col-span-1 rounded-lg bg-white p-4 shadow">
      <h2 class="text-lg font-semibold mb-2">System Time</h2>
      <%= Calendar.strftime(@system_time, "%Y-%m-%d %H:%M:%S") %>
    </div>

    <div class="col-span-1 rounded-lg bg-white p-4 shadow">
      <h2 class="text-lg font-semibold mb-2">Quick Actions</h2>
      <p class="text-gray-500">Coming soon…</p>
    </div>
    """
  end
end
