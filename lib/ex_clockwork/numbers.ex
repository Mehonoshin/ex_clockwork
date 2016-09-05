defmodule ExClockwork.Numbers do
  @doc ~S"""
  Formats number into two digit representation.

  ### Examples
      iex> ExClockwork.Numbers.f(1)
      "01"

      iex> ExClockwork.Numbers.f(12)
      "12"
  """
  def f(num) do
    format_number(num)
  end

  defp format_number(num) when num < 10 do
    "0#{num}"
  end

  defp format_number(num) when num > 9 do
    "#{num}"
  end
end
