defmodule MeryClaire.Settings do

  def all() do
    {globals(), templates(), posts(), assets(), posts()}
  end

  def globals() do
    Application.get_env(:mery_claire, :blog_global)
  end

  def templates() do
    folders = Application.get_env(:mery_claire, :folders)
    Keyword.get(folders, :templates)
  end

  def destination() do
    folders = Application.get_env(:mery_claire, :folders)
    Keyword.get(folders, :destination)
  end

  def posts() do
    folders = Application.get_env(:mery_claire, :folders)
    Keyword.get(folders, :posts)
  end

  def assets() do
    folders = Application.get_env(:mery_claire, :folders)
    Keyword.get(folders, :assets)
  end

  def scss() do
    folders = Application.get_env(:mery_claire, :folders)
    Keyword.get(folders, :scss)
  end


end
