defmodule ExClockwork do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(GenEvent, [[name: EventServer]]),
      worker(ExClockwork.EventHandlerServer, [[name: ExClockwork.EventHandlerServer]]),
      worker(ExClockwork.Ticker, [[name: ExClockwork.Ticker]]),
    ]

    opts = [strategy: :one_for_one, name: ExClockwork.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
