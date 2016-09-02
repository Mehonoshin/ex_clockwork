defmodule ExClockwork.Handler do
  defmacro __using__(_opts) do
    quote do
      import ExClockwork.Handler
      use GenEvent

      def handle_event(:tick, {period, measure}) do
        IO.puts "Handle tick every #{period} #{measure}"
        run()
        {:ok, {period, measure}}
      end
    end
  end
end
