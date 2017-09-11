module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (Route(..))
import UrlParser exposing (..)

matchers : Parser (Route -> a) a
matchers =
        oneOf
            [ UrlParser.map HomeRoute top
            , UrlParser.map CategoriesRoute (s "categories" </> int)
            , UrlParser.map ExercisesRoute (s "exercises" </> int)
            , UrlParser.map TopicsRoute (s "topics" </> int)
            ]

parseLocation : Location ->  Route
parseLocation location =
        case (UrlParser.parsePath matchers location) of
                Just route ->
                        route
                Nothing ->
                        NotFoundRoute

