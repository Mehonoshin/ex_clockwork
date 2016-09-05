defmodule Test.EventHandler2 do
  use ExClockwork.Handler

  def run do
    IO.puts "Handler2 tick"
  end
end
