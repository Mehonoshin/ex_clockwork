defmodule ExClockwork.EventHandlerServerTest do
  use ExUnit.Case, async: true

  test "registred two handlers" do
    assert GenEvent.which_handlers(EventServer) == [Test.EventHandler2, Test.EventHandler1]
  end
end
