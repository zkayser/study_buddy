module Players.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Html.Events exposing (onClick)
import Msgs exposing (Msg)
import Models exposing (Player)
import Routing exposing (playersPath)

view : Player -> Html Msg
view model =
        div []
            [ nav model
            , form model
            ]

nav : Player -> Html Msg
nav model =
        div [ class "clearfix mb2 white bg-black p1" ]
            [ listBtn ]

form : Player -> Html Msg
form player =
        div [ class "m3" ]
            [ h1 [] [ text player.name ]
            , formLevel player
            ]

formLevel : Player -> Html Msg
formLevel player =
        div 
            [ class "clearfix py1" ]
            [ div [ class "col col-5" ] [ text "Level" ]
            , div [ class "col col-7" ] 
                [ span [ class "h2 bold" ] [ text (toString player.level) ]
                , btnLevelDecrease player
                , btnLevelIncrease player
                ]
            ]

btnLevelDecrease : Player -> Html Msg
btnLevelDecrease player =
        let 
            message =
                    Msgs.ChangeLevel player -1
        in
            button [ class "btn ml1 h1", onClick message ] 
                [ text "-" ] 

btnLevelIncrease : Player -> Html Msg
btnLevelIncrease player =
        let 
            message =
                    Msgs.ChangeLevel player 1
        in
            button [ class "btn ml1 h1", onClick message ] 
            [ text "+" ]

listBtn : Html Msg
listBtn =
        a
            [ class "btn regular", href playersPath ]
            [ text "List" ]