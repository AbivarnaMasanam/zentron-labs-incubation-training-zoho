defmodule GuiImageProcessorWeb.PageController do
  use GuiImageProcessorWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
