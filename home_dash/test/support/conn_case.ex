defmodule HomeDash.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Plug.Conn
      import Phoenix.ConnTest
      import HomeDash.ConnCase

      alias HomeDashWeb.Router.Helpers, as: Routes

      @endpoint HomeDashWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(HomeDash.Repo)
    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(HomeDash.Repo, {:shared, self()})
    end
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
