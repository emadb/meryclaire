defmodule MeryClaire.MixProject do
  use Mix.Project

  def project do
    [
      app: :mery_claire,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :html_entities],
      mod: {MeryClaire.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix_markdown, "~> 1.0"},
      {:file_system, "~> 0.2"},
      {:earmark, "~> 1.4"},
      {:plug_cowboy, "~> 2.5"}
    ]
  end
end
