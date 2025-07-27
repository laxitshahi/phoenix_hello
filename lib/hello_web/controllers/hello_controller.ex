defmodule HelloWeb.HelloController do
  # Convinent way to import and define all deps
  # for a Phoenix.Controller
  use HelloWeb, :controller

  def index(conn, _params) do
    # conn has request data
    ## However, it also has an extra value :assigns for additonal data you want to pass through
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
    #1. text(conn, "From messenger #{messenger}")
    #2. json(conn, %{id: messenger}) # must pass something the "Jason" library can decode to json
    # Controller and View MUST share same root name for render/3 function to work
    # render(conn, :show, messenger: messenger, receiver: "Deez") # for phoenix views
    # alternative

    conn
    # conn has request params
    # It also has a field called "assigns", which contains
    # a map that you can store or "assign" additonal values
    # and variables for the view
    |>Plug.Conn.assign(:messenger, messenger)
    |>assign(:receiver, "deez")
    |>render(:show)
  end
    
end
