defmodule ExClockwork.Schedule do
  defmacro __using__(_opts) do
    quote do
      import ExClockwork.Schedule

      @handlers []
      @before_compile ExClockwork.Schedule
    end
  end

  defmacro every(period, measure, module) do
    quote do
      @handlers [{unquote(module), {unquote(period), unquote(measure)}} | @handlers]
    end
  end

  defmacro time(time, module) do
    quote do
      @handlers [{unquote(module), {unquote(time)}} | @handlers]
    end
  end

  defmacro __before_compile__(env) do
    quote do
      def handlers do
        Enum.reverse(@handlers)
      end
    end
  end
end
