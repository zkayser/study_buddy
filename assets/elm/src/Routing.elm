module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (Route(..))
import UrlParser exposing (..)

matchers : Parser (Route -> a) a
matchers =
        oneOf
            [ UrlParser.map HomeRoute top
            ]

parseLocation : Location ->  Route
parseLocation location =
        case (UrlParser.parseHash matchers location) of
                Just route ->
                        route
                Nothing ->
                        NotFoundRoute

