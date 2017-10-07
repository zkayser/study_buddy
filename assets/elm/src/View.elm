module View exposing (..)

import Html exposing (Html, div, text)
import Msgs exposing (Msg)
import Models exposing (Model)
import Page.Layout exposing (layout)
import Page.Home
import Page.Body as Body

view : Model -> Html Msg
view model =
        layout model

page : Model -> Html Msg
page model =
      case model.route of
        Models.HomeRoute ->
            Page.Home.view model
        _ -> Body.page model