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

	3. Run generators to install sample schedule and handlers:

	```elixir
	mix ex_clockwork.install
	```

	4. Configure `ex_clockwork` application, at config/config.exs:
	```elixir
	config :ex_clockwork,
		schedule: ExBlog.Schedule,
		interval: 1000
	```

	`schedule` - module with tasks definitions
	`interval` - parameters sets tick interval, by default it is 1 second, so ex_clockwork will check every second if it has tasks to do.

	5. Configure `schedule.ex` file to add your custom tasks:
	```elixir
		defmodule MyApp.Schedule do
			use ExClockwork.Schedule

			every(2, :second, MyApp.MyEventHandler)
		end
	```

	first parameter - period of your task
	second - measurement, e.g. `:second`, `:minute`, `:hour`
	third - module name, that will be triggered when the period is finished

	6. Customize `my_event_handler.ex` file or create a custom one with definition of work that will be done periodically:
	```elixir
		defmodule MyApp.MyEventHandler do
			use ExClockwork.Handler

			def run do
				# do anything here
			end
		end
	```

	run method of this module will be invoked every 2 seconds, as defined in schedule
>>>>>>> Update README


## TODO
	* Add examples
	* Add tests
	* Add moduledocs
