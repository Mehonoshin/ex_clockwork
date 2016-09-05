defmodule Test.EventHandler1 do
  use ExClockwork.Handler

  def run do
    IO.puts "Handler1 tick"
  end
end
