defmodule HomeDash.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias HomeDash.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import HomeDash.DataCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(HomeDash.Repo)
    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(HomeDash.Repo, {:shared, self()})
    end
    :ok
  end

  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
