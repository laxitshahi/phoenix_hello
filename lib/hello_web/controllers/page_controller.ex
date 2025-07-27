defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  # controllers are plugs, so we can plug our plugs here too
  # here we are saying, "only execute plug for index action"
  plug HelloWeb.Plugs.Locale, "en" when action in [:index]

  def redirect_test(conn, _params) do
    redirect(conn, to: ~p"/")
  end

  # Unused, maybe
  def index(conn, _params) do
    # conn |> render(:index)
    send_resp(conn, 201, "")
  end

  def home(conn, _params) do
    # Can rediredct external/internal
    # redirect(conn, to: ~p"/redirect_test")
    # redirect(conn, external: "https://elixir-lang.org")

    conn
    # |> put_flash(:error, "Pretend there's an error here, ok?")
    |> put_flash(:info, "Pretend there's a reason this is here, ok?")
    |> render(:home, layout: false)

    # The home page is often custom made,
    # so skip the default app layout.
    # Basic
    # render(conn, :home, layout: false)

    # The view in phoenix doesn't ALWAYS render with HTML only, 
    # it can render based on different formats set in the module.ex
    # hello_web.ex in our case (inside def controller do)
    # Default setup is
    # plug :put_view, html: HelloWeb.PageHTML, json: HelloWeb.PageJSON
    # It also needs to be set in the :browser pipline to ensure it's accepted (router.ex)

    # Adding ?_format=json will render HelloWeb.PageJson
    # but generally, json + api use two different pipelines

    # CUSTOM response also possible
    # send_resp(conn, 201, "")
    # conn
    # |> put_resp_content_type("text/plain")
    # |> send_resp(201, "")

    # There are a variety of content types avaiavailable: https://hexdocs.pm/mime/2.0.6/MIME.html

    # Putting status
    # conn
    # |> put_status(202)
    # |> render(:home, layout: false)
  end
end
