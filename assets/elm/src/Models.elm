module Models exposing (..)

import RemoteData exposing (WebData)
import Users.User as User exposing (..)
import Token exposing (Token)
import Page.LoginForm as LoginForm
import Material

type alias Model =
        { mdl : Material.Model
        , user : WebData User
        , route : Route
        , loginForm : LoginForm.Form
        , jwt : Token
        , errorMessage : String
        }

type alias Flags =
  { token : Maybe String }

initialModel : Flags -> Route -> Model
initialModel flags route =
  let
    tkn = flags.token
  in
    { mdl = Material.model
    , user = RemoteData.NotAsked
    , route = route
    , loginForm = LoginForm.initialLoginForm
    , jwt = { jwt = tkn }
    , errorMessage = ""
    }

type Route
    = HomeRoute
    | NotFoundRoute
