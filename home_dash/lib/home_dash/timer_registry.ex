defmodule HomeDash.TimerRegistry do
  use DynamicSupervisor

  def start_link(_opts) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_or_stop_timer(id) do
    case Registry.lookup(HomeDash.TimerRegistry.Registry, id) do
      [] -> start_timer(id)
      [{pid, _}] -> stop_timer(pid)
    end
  end

  defp start_timer(id) do
    spec = {HomeDash.TimerServer, id}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  defp stop_timer(pid) do
    DynamicSupervisor.terminate_child(__MODULE__, pid)
  end
end
