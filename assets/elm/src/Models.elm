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

initialModel : Route -> Model
initialModel route =
        { mdl = Material.model
        , players = RemoteData.Loading
        , user = RemoteData.NotAsked
        , route = route
        , loginForm = LoginForm.initialLoginForm
        , jwt = { jwt = "" }
        , errorMessage = ""
        }

type Route
    = HomeRoute
    | PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute
