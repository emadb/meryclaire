defmodule MeryClaire.StaticServer do
  use Plug.Router

  plug(Plug.Static,
    at: "/",
    from: "docs"
  )

  plug(:match)
  plug(:dispatch)

  get "/" do
    content = File.read!("./docs/index.html")

    conn
    |> put_resp_header("content-type", "text/html")
    |> send_resp(200, content)
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
