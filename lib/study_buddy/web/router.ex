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
    plug :fetch_session
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/api", StudyBuddyWeb do
    pipe_through :api
    get "/players", PlayerController, :index
    get "/players/:id", PlayerController, :show
    post "/players/:id", PlayerController, :update
    resources "/sessions", SessionController, only: [:delete, :create]
    pipe_through :api_auth
    resources "/users", UserController, except: [:new, :edit]
    resources "/categories", CategoryController, except: [:new, :edit]
  end

  scope "/", StudyBuddyWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
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


  # Other scopes may use custom stacks.
  # scope "/api", StudyBuddyWeb do
  #   pipe_through :api
  # end
end
