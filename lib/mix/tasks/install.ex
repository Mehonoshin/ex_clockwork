defmodule Mix.Tasks.ExClockwork.Install do
  use Mix.Task
  import Mix.Generator

  @shortdoc "Install ExClockwork schedule and optionally sample handlers"

  @default_options [schedule: true, handlers: true, config: true]
  @negative_options [no_schedule: :schedule, no_handlers: :handlers, no_config: :config]

  @config_marker_start "%% ExClockwork Configuration %%"
  @config_marker_end   "%% End ExClockwork Configuration %%"

  def run(args) do
    opts = prepare_options(args)
    Mix.shell.info "#{inspect opts}"
  end

  defp install_schedule do
  end

  defp install_handlers do
  end

  defp install_config do
  end

  defp prepare_options(args) do
    {opts, parsed, unknown} = OptionParser.parse(args)

    opts = Enum.reduce(opts, [], fn({key, value}, acc) ->
      case Keyword.fetch(@negative_options, key) do
        {:ok, positive_key} -> acc |> Keyword.put(positive_key, false) |> Keyword.delete(key)
        :error -> Keyword.put(acc, key, value)
      end
    end)

    Keyword.merge(@default_options, opts)
  end
end
