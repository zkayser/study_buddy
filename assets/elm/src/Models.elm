module Models exposing (..)

import RemoteData exposing (WebData)
import Users.User as User exposing (..)
import Players.Model exposing (Player, PlayerId)
import Token exposing (Token)
import Page.LoginForm as LoginForm
import Material

type alias Model =
        { mdl : Material.Model
        , players : WebData (List Player)
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
    tkn =
      case flags.token of
        Just token -> token
        Nothing -> ""
  in
    { mdl = Material.model
    , players = RemoteData.Loading
    , user = RemoteData.NotAsked
    , route = route
    , loginForm = LoginForm.initialLoginForm
    , jwt = { jwt = tkn }
    , errorMessage = ""
    }

type Route
    = HomeRoute
    | PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute
