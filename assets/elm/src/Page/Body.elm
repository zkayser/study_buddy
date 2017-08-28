module Page.Body exposing (page)

import Html exposing (..)
import Models exposing (Model, Route)
import Msgs exposing (Msg(..))
import Players.List
import Page.Home exposing (view)
import Material.Grid as Grid
import Material.Typography as Typography

page : Model -> Html Msg
page model =
  case model.route of
    Models.HomeRoute ->
      Page.Home.view model.user model.loginForm model.jwt.jwt model.mdl
    Models.PlayersRoute ->
      Players.List.view model.players
    Models.PlayerRoute playerId ->
      notFoundView
    Models.NotFoundRoute ->
      notFoundView

notFoundView : Html Msg
notFoundView =
  div []
    [ text "Not Found" ]
