defmodule ExClockwork.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_clockwork,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [mod: {ExClockwork, []},
     applications: [:logger],
     env: [
       interval: 1000,
       schedule: Test.Schedule
     ]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    []
  end

  defp description do
    """
      This package allows you to run tasks at specified periods of time. Similar to ruby `clockwork` gem.
    """
  end

  defp package do
    [
      files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
      maintainers: ["Stanislav Mekhonoshin"],
      licenses: ["MIT"],
      links: ["https://github.com/Mehonoshin/ex_clockwork"]
    ]
  end
end
