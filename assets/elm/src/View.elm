module View exposing (..)

import Html exposing (Html, div, text)
import Msgs exposing (Msg)
import Models exposing (Model)
import Players.Model exposing (PlayerId)
import Page.Layout exposing (layout)
import Page.Home
import Material.Grid as Grid
import Material.Typography as Typography
import Players.List
import Players.Edit
import RemoteData

view : Model -> Html Msg
view model =
        layout model

{-
 I moved this for all intents and purposes to
 the Page/ directory and placed in the Page.Body module
-}
-- Should be able to take the resources that you want and
-- have individual views for each of them based on their own
-- models. This will help keep things compartmentalized and
-- easier to work with. Then, you can pass in the main model
-- and call `.{resourceName}` on it to get the proper view.
page : Model -> Html Msg
page model =
      case model.route of
        Models.HomeRoute ->
          Page.Home.view model.user model.loginForm 
        Models.PlayersRoute ->
          Players.List.view model.players
        Models.PlayerRoute id ->
          playerEditPage model id
        Models.NotFoundRoute ->
          div [] [ text "Not found..." ]

playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
        case model.players of
                RemoteData.NotAsked ->
                        text ""

                RemoteData.Loading ->
                        text "Loading..."

                RemoteData.Success players ->
                        let
                            maybePlayer =
                                    players
                                    |> List.filter (\player -> player.id == playerId)
                                    |> List.head
                        in
                            case maybePlayer of
                                    Just player ->
                                            Players.Edit.view player

                                    Nothing ->
                                           div [] [ text "Not found..." ]

                RemoteData.Failure err ->
                        text (toString err)
