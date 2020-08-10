defmodule ReproduceWeb.Router do
  use ReproduceWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ReproduceWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ReproduceWeb do
    pipe_through :browser

    live "/", PageLive, :index

    live "/item", ItemLive.Index, :index
    live "/item/new", ItemLive.Index, :new
    live "/item/:id/edit", ItemLive.Index, :edit

    live "/item/:id", ItemLive.Show, :show
    live "/item/:id/show/edit", ItemLive.Show, :edit

    live "/product", ProductLive.Index, :index
    live "/product/new", ProductLive.Index, :new
    live "/product/:id/edit", ProductLive.Index, :edit

    live "/product/:id", ProductLive.Show, :show
    live "/product/:id/show/edit", ProductLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", ReproduceWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ReproduceWeb.Telemetry
    end
  end
end
