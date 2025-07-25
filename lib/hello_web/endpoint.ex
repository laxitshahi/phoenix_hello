# This runs first and on all endpoints?
defmodule HelloWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :hello

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_hello_key",
    signing_salt: "g3mX4Qm4",
    same_site: "Lax"
  ]

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :hello,
    gzip: false,
    only: HelloWeb.static_paths()

  # Code reloading (dev only) can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :hello
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  # parse request body if urlencoded, multipart, or json 
  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  # ONLY sets up session management, so fetch_session/2 must be explicitly called before using the session
  plug Plug.Session, @session_options
  plug HelloWeb.Router

  # plugs are kinds like middleware as they are adapters 
  # that sit between "connections" rather than
  # a req/res cycle like normal HTTP middleware
  plug :introspect
  # between each page, this will run and output in console
  # PLUGS CAN BE FUNCTIONS OR MODULES
  def introspect(conn, _opts) do
    IO.puts("""
    Verb (get,post...): #{inspect(conn.method)}
    Host (ex.localhost): #{inspect(conn.host)}
    Headers: #{inspect(conn.req_headers)} 
    """)
    
    conn
  end
end
