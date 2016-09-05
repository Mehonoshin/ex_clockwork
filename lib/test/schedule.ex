defmodule Test.Schedule do
  use ExClockwork.Schedule

  every(1, :second, Test.EventHandler1)
  time("16:27:00", Test.EventHandler2)
end


