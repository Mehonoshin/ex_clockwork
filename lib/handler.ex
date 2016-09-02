defmodule ExClockwork.Handler do
  defmacro __using__(_opts) do
    quote do
      import ExClockwork.Handler
      use GenEvent

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
        "#{f(hour)}:#{f(minute)}:#{f(second)}" == time
      end

      defp tick_interval do
        Application.fetch_env!(:ex_clockwork, :interval)
      end

      defp f(num) do
        format_number(num)
      end

      defp format_number(num) when num < 10 do
        "0#{num}"
      end

      defp format_number(num) when num > 9 do
        num
      end
    end
  end
end
