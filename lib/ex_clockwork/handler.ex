defmodule ExClockwork.Handler do
  defmacro __using__(_opts) do
    quote do
      import ExClockwork.Handler
      use GenEvent
      alias ExClockwork.Numbers

      @periods %{
        second: 1000,
        minute: 60000,
        hour:   360000
      }

      def init({period, measure}) do
        {:ok, {period, measure, 0}}
      end

      def init({time}) do
        {:ok, {time}}
      end

      def handle_event(:tick, {period, measure, current_time}) do
        if process_tick?({period, measure, current_time}), do: run()
        {:ok, {period, measure, current_time + tick_interval}}
      end

      def handle_event(:tick, {time}) do
        if process_tick?({time}), do: run()
        {:ok, {time}}
      end

      defp process_tick?({period, measure, current_time}) do
        case rem(current_time, period * @periods[measure]) do
          0 -> true
          _ -> false
        end
      end

      defp process_tick?({time}) do
        {_, {hour, minute, second}} = :calendar.local_time()
        "#{Numbers.f(hour)}:#{Numbers.f(minute)}:#{Numbers.f(second)}" == time
      end

      defp tick_interval do
        Application.fetch_env!(:ex_clockwork, :interval)
      end
    end
  end
end
