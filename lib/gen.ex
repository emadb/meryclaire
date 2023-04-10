defmodule Mix.Tasks.Gen do
  use Mix.Task

  @shortdoc "build the blog"
  def run(_args) do
   MeryClaire.Generator.run()
  end


end
