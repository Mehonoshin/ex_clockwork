# ExClockwork

This package allows you to run tasks at specified periods of time. Similar to ruby `clockwork` gem.

Currently is under development.

## Installation

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

	3. Configure `ex_clockwork` application, adding to config/config.exs:
	```elixir
	config :ex_clockwork,
		schedule: ExBlog.Schedule,
		interval: 1000
	```
	where `schedule` is the module with your tasks definitions

	3. Add `schedule.ex` file to your application, with something like this content:
	```elixir
		defmodule MyApp.Schedule do
			use ExClockwork.Schedule

			every(2, :second, MyApp.MyEventHandler)
		end
	```

	4. Add `my_event_handler.ex` file to your app.
	```elixir
		defmodule MyApp.MyEventHandler do
			use ExClockwork.Handler

			def run do
				# do anything here
			end
		end
	```

	run method of this module will be invoked every 2 seconds, as defined in schedule


## TODO

	* Add examples
	* Add some kind of generators, to install sample schedule and handler, to prevent extra work from user
