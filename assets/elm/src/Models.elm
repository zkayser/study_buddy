module Models exposing (..)

import RemoteData exposing (WebData)
import Users.User as User exposing (..)
import Material

type alias Model =
        { mdl : Material.Model 
        , players : WebData (List Player) 
        , user : WebData User
        , route : Route
        }

initialModel : Route -> Model
initialModel route =
        { mdl = Material.model 
        , players = RemoteData.Loading
        , user = RemoteData.Loading
        , route = route
        }

type alias PlayerId =
        String

type alias Player =
        { id : PlayerId
        , name : String
        , level : Int
        }

type Route
    = HomeRoute
    | PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute

