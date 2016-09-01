defmodule ExClockwork.Ticker do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(_) do
    schedule_tick()
    {:ok, %{}}
  end

  def handle_info(:tick, state) do
    schedule_tick()
    GenEvent.notify(EventServer, :tick)
    {:noreply, state}
  end

  defp schedule_tick do
    # TODO: move tick interval to config
    Process.send_after(self(), :tick, interval)
  end

  defp interval do
    Application.fetch_env!(:ex_clockwork, :interval)
  end
end
