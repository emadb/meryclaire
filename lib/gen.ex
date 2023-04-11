defmodule Mix.Tasks.Gen do
  use Mix.Task

  @shortdoc "build the blog"
  def run(args) do
    env =
      case args do
        [] -> nil
        [env] -> env
        _ -> nil
      end

    MeryClaire.Generator.run(env)
  end
end
