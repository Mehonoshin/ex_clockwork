defmodule Mix.Tasks.ExClockwork.Install do
  use Mix.Task
  import Mix.Generator

  @shortdoc "Install ExClockwork schedule and optionally sample handlers"

  @default_options [schedule: true, handlers: true, config: true]
  @negative_options [no_schedule: :schedule, no_handlers: :handlers, no_config: :config]

  @config_marker_start "%% ExClockwork Configuration %%"
  @config_marker_end   "%% End ExClockwork Configuration %%"

  @config_file "config/config.exs"
  @default_schedule_file "lib/schedule.ex"
  @default_handlers_directory "lib/schedule_handlers"
  @sample_hander_file "my_event_handler.ex"

  def run(args) do
    args
    |> prepare_options
    |> Enum.into(%{})
    |> Enum.each fn
      {:schedule, true} -> install_schedule
      {:handlers, true} -> install_handlers
      {:config, true}   -> install_config
    end
  end

  defp prepare_options(args) do
    {opts, parsed, unknown} = OptionParser.parse(args)

    opts = Enum.reduce(opts, @default_options, fn({key, value}, acc) ->
      case Keyword.fetch(@negative_options, key) do
        {:ok, positive_key} -> acc |> Keyword.delete(positive_key) |> Keyword.delete(key)
        :error -> Keyword.put(acc, key, value)
      end
    end)
  end

  defp install_schedule do
    schedule_value = """
    defmodule #{base}.Schedule do
      use ExClockwork.Schedule

      # Sample event handler
      # every(1, :second, #{base}.MyEventHandler)
    end
    """

    if File.exists?(@default_schedule_file) do
      Mix.shell.info "Your schedule file already exists."
    else
      create_file(@default_schedule_file, schedule_value)
      Mix.shell.info "Schedule file successfully created."
    end
  end

  defp install_handlers do
    handler_value = """
    defmodule #{base}.MyEventHandler do
      use ExClockwork.Handler

      def run do
        # do anything here
      end
    end
    """

    create_directory(@default_handlers_directory)
    create_file(@default_handlers_directory <> "/" <> @sample_hander_file, handler_value)
  end

  defp install_config do
    config_value = """
    # #{@config_marker_start}   Don't remove this line
    config :ex_clockwork,
      schedule: #{base}.Schedule,
      interval: 1000
    # #{@config_marker_end}   Don't remove this line
    """

    source = File.read!(@config_file)
    if String.contains? source, @config_marker_start do
      Mix.shell.info "Your config file already contains ExClockwork configuration."
    else
      File.write!(@config_file, source <> "\n" <> config_value)
      Mix.shell.info "ExClockwork configuration is added to config/config.ex"
    end
  end

  defp base do
    binding = Mix.Project.config
    |> Keyword.fetch!(:app)
    |> Atom.to_string
    |> Mix.Phoenix.inflect
    binding[:base]
  end
end
