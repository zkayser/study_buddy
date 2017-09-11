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
    Models.CategoriesRoute id ->
        Html.div [] [ Html.text ("You are on the Categories Page. Category id:" ++ (toString id)) ]
    Models.TopicsRoute id ->
        Html.div [] [ Html.text ("You are on the Topics Page. Topic id: " ++ (toString id))]
    Models.ExercisesRoute id ->
        Html.div [] [ Html.text ("You are on the Exercises Page. Exercise id: " ++ (toString id))]
    Models.NotFoundRoute ->
      notFoundView

notFoundView : Html Msg
notFoundView =
  div []
    [ text "Not Found" ]
