defmodule HomeDashWeb.ErrorView do
  use HomeDashWeb, :html

  embed_templates "../templates/error/*"

  def render("500.html", _assigns), do: "Internal Server Error"
  def render("404.html", _assigns), do: "Not Found"
end
