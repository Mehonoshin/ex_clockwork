defmodule ExClockwork.EventHandlerServer do
  use GenEvent

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(opts) do
    #:ok = GenEvent.add_handler(EventServer, CollectorScheduler.EventHandler, self())
    #:ok = GenEvent.add_handler(EventServer, CollectorScheduler.EventHandler2, self())
    IO.puts "Starting event handlers"
    {:ok, opts}
  end
end
