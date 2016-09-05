defmodule ExClockwork.NumbersTest do
  use ExUnit.Case, async: true
  doctest ExClockwork.Numbers

  test "adds zero to single digit number" do
    number = 1
    assert ExClockwork.Numbers.f(number) == "01"
  end

  test "does not add zero to two digit number" do
    number = 14
    assert ExClockwork.Numbers.f(number) == "14"
  end
end
