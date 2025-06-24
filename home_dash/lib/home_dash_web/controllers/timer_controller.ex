defmodule HomeDashWeb.TimerController do
  use HomeDashWeb, :controller

  def create(conn, %{"id" => id}) do
    case HomeDash.TimerRegistry.start_or_stop_timer(id) do
      :ok -> send_resp(conn, 204, "")
      {:error, reason} -> send_resp(conn, 400, inspect(reason))
    end
  end
end
