defmodule HelloWeb.Router do
 use HelloWeb, :router

  # pipeline allows plugs to be applied at particular routes
  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_live_flash # liveview flash messages
    plug :put_root_layout, html: {HelloWeb.Layouts, :root} # renders root and app layouts
    # CSRF protection
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug HelloWeb.Plugs.Locale, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloWeb do
    # invoke all plus in browser pipeline above
    pipe_through :browser

    # get,post,patch,connect,options... are all macros

    # Using macros for routes allow us to make
    # the use of routes, faster and safer.
    # faster -> optmized by erlang VM
    # safer -> meta data for Phoenix.VerifiedRoutes is implemented
    get "/", PageController, :home
    get "/redirect_test", PageController, :redirect_test
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show

    # We can also define resources to "generate"
    # a number of different routes
    # You can specific the TYPE of route using 
    # the respective function definition

    #== NOTE: DNE (used for routing section) ==#
    resources "/people", PeopleController, only: [:index]
    resources "/comments", CommentController, except: [:delete]

    # You can also created nested routes for 1:M relation ships
    #== NOTE: DNE (used for routing section) ==#
    resources "/users", UserController do
      resources "/posts", PostController
    end
  end
  
  # You can "scope" apis to have a common start
  scope "/admin", HelloWeb.Admin do
    pipe_through :browser
    
    #== NOTE: DNE (used for routing section) ==#
    resources "/reviews", ReviewController
  end


  # Other scopes may use custom stacks.
  # scope "/api", HelloWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:hello, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HelloWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
