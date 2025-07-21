defmodule HelloWeb.HelloController do
  # Convinent way to import and define all deps
  # for a Phoenix.Controller
  use HelloWeb, :controller

  def index(conn, _params) do
    # conn has request data
    # params has params data

    # render with :index template
    # pass in conn data to this template
    render(conn, :index)
    # Expects HelloWeb.HelloHTML to exist with
    # index/1 function
  end

  # We are essentially stripping out values from the params
  # REMEMBER, = is a pattern match, so we are matching the "messenger" value from the param
  # i.e. %{"messenger" => messenger} = params
  def show(conn, %{"messenger" => messenger}) do
    render(conn, :show, messenger: messenger)
  end
    
end
