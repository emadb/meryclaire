defmodule Mix.Tasks.Serve do
  use Mix.Task

  @shortdoc "Run a developer server"
  def run(args) do
    Application.ensure_all_started(:mery_claire)
    Application.load(:mery_claire)

    Mix.Tasks.Gen.run(args)

    Mix.Task.run("run", run_args() ++ args)

    IO.puts("Server is running on port 4000: http://localhost:4000")
  end

  defp iex_running? do
    Code.ensure_loaded?(IEx) && IEx.started?()
  end

  defp run_args do
    if iex_running?(), do: [], else: ["--no-halt"]
  end
end
