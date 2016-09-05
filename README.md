# ExClockwork

This package allows you to run tasks at specified periods of time. Similar to ruby `clockwork` gem.

Currently is under development.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `ex_clockwork` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ex_clockwork, "~> 0.1.0"}]
    end
    ```

  2. Ensure `ex_clockwork` is started before your application:

    ```elixir
    def application do
      [applications: [:ex_clockwork]]
    end
    ```

