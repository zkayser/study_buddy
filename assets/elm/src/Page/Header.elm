module Page.Header exposing (header)

import Models exposing (Model)
import Html exposing (..)
import Msgs exposing (Msg(..))
import Material.Layout as Layout
import Material.Options as Options
import Material.Icon as Icon

header : Model -> List (Html Msg)
header model =
        [ Layout.row
            [ Options.nop, Options.css "transition" "height 333ms ease-in-out 0s" ]
            [ Layout.title [] [ text "Study Buddy" ]
            , Layout.spacer
            , Layout.navigation []
                [ Layout.link [] [ Icon.i "photo" ]
                , Layout.link
                [ Layout.href "https://www.github.com/zkayser" ]
                [ Html.span [] [ text "Github" ] ]
                , Layout.link
                [ Layout.href "https://www.elixir-lang.org" ]
                [ Html.span [] [ text "Elixir" ] ]
                ]
            ]
        ]
