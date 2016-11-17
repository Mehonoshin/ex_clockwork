defmodule Mix.Tasks.ExClockwork.Install do
  use Mix.Task
  import Mix.Generator

  @shortdoc "Install ExClockwork schedule and optionally sample handlers"

  @default_options [schedule: true, handlers: true, config: true]
  @negative_options [no_schedule: :schedule, no_handlers: :handlers, no_config: :config]

  @config_marker_start "%% ExClockwork Configuration %%"
  @config_marker_end   "%% End ExClockwork Configuration %%"

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
    Mix.shell.info "schedule"
  end

  defp install_handlers do
    Mix.shell.info "handlers"
  end

  defp install_config do
    Mix.shell.info "config"
  end
end