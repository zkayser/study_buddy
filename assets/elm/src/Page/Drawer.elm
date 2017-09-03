module Page.Drawer exposing (drawer)

import Models exposing (Model)
import Html exposing (Html)
import Msgs exposing (Msg(..))

drawer : Model -> List (Html Msg)
drawer model =
    [ Html.div [] [] ]