defmodule ExClockwork.EventHandlerServer do
  use GenEvent

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(opts) do
    IO.puts "Starting event handlers"
    subscribe(schedule.handlers)
    {:ok, opts}
  end

  defp subscribe([handler | handlers]) do
    :ok = GenEvent.add_handler(EventServer, handler, self())
    subscribe(handlers)
  end

  defp subscribe([]) do
  end

  defp schedule do
    Application.fetch_env!(:ex_clockwork, :schedule)
  end
end
