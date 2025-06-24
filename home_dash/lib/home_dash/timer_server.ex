defmodule HomeDash.TimerServer do
  use GenServer

  def start_link(id) do
    GenServer.start_link(__MODULE__, %{id: id}, name: via(id))
  end

  def init(state) do
    schedule_tick()
    {:ok, state}
  end

  def handle_info(:tick, state) do
    Phoenix.PubSub.broadcast(HomeDash.PubSub, "timers", {:timer_tick, state.id, System.system_time(:millisecond)})
    schedule_tick()
    {:noreply, state}
  end

  defp schedule_tick do
    Process.send_after(self(), :tick, 1000)
  end

  defp via(id) do
    {:via, Registry, {HomeDash.TimerRegistry.Registry, id}}
  end
end
