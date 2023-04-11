defmodule MeryClaire.Application do
  use Application
  alias MeryClaire.Settings

  @impl true
  def start(_type, _args) do
    dirs = [Settings.assets(), Settings.templates(), Settings.posts()]

    children = [
      {Plug.Cowboy, scheme: :http, plug: MeryClaire.StaticServer, options: [port: 4000]},
      {MeryClaire.FileWatcher, [dirs: dirs]}
    ]

    opts = [strategy: :one_for_one, name: MeryClaire.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
