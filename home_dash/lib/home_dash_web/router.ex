defmodule HomeDashWeb.Router do
  use HomeDashWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {HomeDashWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HomeDashWeb do
    pipe_through :api
    post "/timers/:id", TimerController, :create
  end

  scope "/", HomeDashWeb do
    pipe_through :browser
    live "/", HomeLive, :index
  end
end
