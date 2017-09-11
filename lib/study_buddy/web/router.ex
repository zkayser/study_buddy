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
    resources "/sessions", SessionController, only: [:delete, :create]

    pipe_through :api_auth
    resources "/users", UserController, except: [:new, :edit]
    resources "/categories", CategoryController, except: [:new, :edit]
    resources "/topics", TopicController, except: [:new, :edit]
    resources "/exercises", ExerciseController, except: [:new, :edit]
  end

  scope "/", StudyBuddyWeb do
    pipe_through :browser # Use the default browser stack

    get "/*path", PageController, :index
  end
end
