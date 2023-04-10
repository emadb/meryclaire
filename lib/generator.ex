defmodule MeryClaire.Generator do
  alias MeryClaire.Settings

  def run() do
    generate_posts()
    generate_index()
    generate_about()
    generate_archive()
    generate_css()
    copy_assets()
  end

  defp generate_posts() do
    Path.wildcard("#{Settings.posts()}/*.md")
    |> Enum.sort_by(&(&1), :desc)
    |> Enum.map(&get_header/1)
    |> Enum.map(&generate_post/1)
  end

  defp generate_archive() do
    post_list =Path.wildcard("#{Settings.posts()}/*.md")
    |> Enum.sort_by(&(&1), :desc)
    |> Enum.map(&get_header/1)
    |> Enum.map(&Enum.into(&1, %{}))

    globals = Settings.globals()
    destination = Settings.destination()
    page = compose_html("archive.html.heex")
    index = EEx.eval_string(page, [posts: post_list] ++ globals)
    File.write("#{destination}/archive.html", index)
  end

  defp get_header(file) do
    content = File.read!(file)
    [_, head, _] = String.split(content, "---")

    header = parse_header(head)
    out_file = get_filename(header)

    header
    |> Keyword.put(:url, out_file)
    |> Keyword.put(:file, file)
  end

  defp copy_assets() do
    File.cp_r(Settings.assets(), Settings.destination())
  end

  defp generate_css() do
    # %{output_style: Sass.sass_style_compressed}
    file_name = Path.basename(Settings.scss(), Path.extname(Settings.scss()))
    {:ok, css} = Sass.compile_file("#{Settings.scss()}")
    :ok = File.write!("#{Settings.destination()}/#{file_name}.css", css, [:write])
  end

  defp generate_about() do
    globals = Settings.globals()
    destination = Settings.destination()

    page = compose_html("about.html.heex")
    about = EEx.eval_string(page, globals)
    File.write("#{destination}/about.html", about)
  end

  defp compose_html(file) do
    templates = Settings.templates()
    sk = File.read!("#{templates}/skeleton.html.heex")
    content = File.read!("#{templates}/#{file}")
    String.replace(sk, "{{=content=}}", content)
  end

  defp generate_index() do
    posts = Path.wildcard("#{Settings.posts()}/*.md")
    |> Enum.sort_by(&(&1), :desc)
    |> Enum.take(5)
    |> Enum.map(&get_header/1)

    globals = Settings.globals()
    destination = Settings.destination()

    posts = Enum.map(posts, &Enum.into(&1, %{}))
    html = compose_html("index.html.heex")
    index = EEx.eval_string(html, [posts: posts] ++ globals)
    File.write("#{destination}/index.html", index)
  end

  defp generate_post(header) do
    globals = Settings.globals()
    destination = Settings.destination()

    content = File.read!(header[:file])
    [_, _, body] = String.split(content, "---")

    out_file = get_filename(header)
    html = MdParser.compile(body, out_file)
    page = compose_html("post.html.heex")
    result = EEx.eval_string(page, [content: html] ++ header ++ globals)

    File.write("#{destination}/#{out_file}", result)
  end

  defp get_filename(header) do
    date = header[:date]
    title = header[:title]
    String.replace("#{date}_#{title}.html", " ", "_")
  end

  defp parse_header(head) do
    head
    |> String.split("\n")
    |> Enum.reject(fn l -> l == "" end)
    |> Enum.reduce(Keyword.new(), fn l, acc ->
      [k, v] = String.split(l, ":", trim: true)
      Keyword.put(acc, String.to_atom(k), String.trim(v))
    end)
  end

end
