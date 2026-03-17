defmodule TaskManagerGuiWeb.PageController do
  use TaskManagerGuiWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
