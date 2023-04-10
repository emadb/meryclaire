import Config

config :phoenix, :template_engines,
    md: PhoenixMarkdown.Engine

config :phoenix_markdown, :earmark, %{
  gfm: true,
  breaks: true
}

config :mery_claire, :blog_global,
  blog_title: "MeryClaire",
  blog_description: "A static blog generator"

config :mery_claire, :folders,
  posts: "./_posts",
  templates: "./_templates",
  destination: "./docs",
  assets: "./_assets"
