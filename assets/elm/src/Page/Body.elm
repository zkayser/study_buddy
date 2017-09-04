module Page.Body exposing (page)

import Html exposing (..)
import Models exposing (Model, Route)
import Msgs exposing (Msg(..))
import Page.Home exposing (view)
import Material.Grid as Grid
import Material.Typography as Typography

page : Model -> Html Msg
page model =
  case model.route of
    Models.HomeRoute ->
      Page.Home.view model
    Models.NotFoundRoute ->
      notFoundView

notFoundView : Html Msg
notFoundView =
  div []
    [ text "Not Found" ]
