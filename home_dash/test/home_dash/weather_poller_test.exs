defmodule HomeDash.WeatherPollerTest do
  use HomeDash.DataCase

  test "poll/1 handles 200" do
    body = %{temp: 20}
    req = fn _ -> {:ok, %{status: 200, body: body}} end
    assert {:ok, ^body} = HomeDash.WeatherPoller.poll(req)
  end

  test "poll/1 handles error" do
    req = fn _ -> {:ok, %{status: 500}} end
    assert {:error, 500} = HomeDash.WeatherPoller.poll(req)
  end
end
