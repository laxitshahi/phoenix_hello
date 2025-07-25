defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  # controllers are plugs, so we can plug our plugs here too
  # here we are saying, "only execute plug for index action"
  plug HelloWeb.Plugs.Locale, "en" when action in [:index]

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end
end
