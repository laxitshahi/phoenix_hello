defmodule HelloWeb.Plugs.Locale do
  # Plug modules implement only two functions
  # init/1 and call/2
  import Plug.Conn

  @locales ["en", "fr", "de"]

  # do: is just a way to shorten do end
  def init(default), do: default

  # The structure of conn is something like:
  # %Plug.conn{...params: %{"locale" => loc,...}...}
  # We are just matching on this to automatically assign the "locale" value to loc
  def call(%Plug.Conn{params: %{"locale" => loc}} = conn, _default) when loc in @locales do
    assign(conn, :locale, loc)
  end

  def call(conn, default) do
    assign(conn, :locale, default)
  end
end
