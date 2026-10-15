defmodule GuiPmageProcessingWeb.PageController do
  use GuiPmageProcessingWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
