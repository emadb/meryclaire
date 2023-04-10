import Config

config :phoenix, :template_engines,
    md: PhoenixMarkdown.Engine

config :phoenix_markdown, :earmark, %{
  gfm: true,
  breaks: true
}

config :mery_claire, :blog_global,
  blog_title: "This is the blog title",
  blog_description: "A short description on how this blog works"

config :mery_claire, :folders,
  posts: "./_posts",
  templates: "./_templates",
  destination: "./docs",
  assets: "./_assets"
