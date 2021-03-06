defmodule HelpdeskWeb.Router do
  use HelpdeskWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HelpdeskWeb do
    pipe_through :api # Use the default browser stack
    resources "/users", UserController, except: [:new, :edit]
    resources "/tickets", TicketController, except: [:new, :edit]
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelpdeskWeb do
  #   pipe_through :api
  # end
end
