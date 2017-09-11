module View exposing (..)

import Html exposing (Html, div, text)
import Msgs exposing (Msg)
import Models exposing (Model)
import Page.Layout exposing (layout)
import Page.Home

view : Model -> Html Msg
view model =
        layout model

page : Model -> Html Msg
page model =
      case model.route of
        Models.HomeRoute ->
            Page.Home.view model
        Models.CategoriesRoute id ->
            div [] [ text ("You are on the categories page. Category id: " ++ (toString id)) ]
        Models.TopicsRoute id ->
            div [] [ text ("You are on the topics page. Topic id: " ++ (toString id))]
        Models.ExercisesRoute id ->
            div [] [ text ("You are on the exercises page. Exercise id: " ++ (toString id)) ]
        Models.NotFoundRoute ->
            div [] [ text "Not found..." ]