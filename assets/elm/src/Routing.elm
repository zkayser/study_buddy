module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (Route(..))
import Players.Model exposing (PlayerId)
import UrlParser exposing (..)

matchers : Parser (Route -> a) a
matchers =
        oneOf
            [ UrlParser.map HomeRoute top
            , UrlParser.map PlayerRoute (s "players" </> string)
            , UrlParser.map PlayersRoute (s "players")
            ]

parseLocation : Location ->  Route
parseLocation location =
        case (UrlParser.parseHash matchers location) of
                Just route ->
                        route
                Nothing ->
                        NotFoundRoute

playersPath : String
playersPath =
        "#players"

playerPath : PlayerId -> String
playerPath playerId =
        "#players/" ++ playerId
