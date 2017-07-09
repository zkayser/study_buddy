defmodule StudyBuddy.Web.Router do
  use StudyBuddy.Web, :router

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

  scope "/", StudyBuddy.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, except: [:new, :edit]
  end

  scope "/users/:id/" do
    resources "/categories", CategoryController
    scope "/categories/:id" do
      resources "/topics", TopicController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", StudyBuddy.Web do
  #   pipe_through :api
  # end
end
