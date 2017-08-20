defmodule StudyBuddyWeb.Router do
  use StudyBuddyWeb, :router

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

  scope "/", StudyBuddyWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, except: [:new, :edit]
  end

  scope "/users/:id/" do
    resources "/categories", CategoryController
    scope "/categories/:id" do
      resources "/topics", TopicController
      scope "/topics/:id" do
        resources "/exercises", ExerciseController
      end
    end
  end

  scope "/api", StudyBuddyWeb do
    pipe_through :api
    get "/players", PlayerController, :index
    get "/players/:id", PlayerController, :show
    post "/players/:id", PlayerController, :update
    resources "/sesssions", SessionController, only: [:delete, :create]
  end
  # Other scopes may use custom stacks.
  # scope "/api", StudyBuddyWeb do
  #   pipe_through :api
  # end
end
