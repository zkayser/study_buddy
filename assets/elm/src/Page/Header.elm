module Page.Header exposing (header)

import Models exposing (Model)
import Html exposing (..)
import Msgs exposing (Msg(..))
import Material.Layout as Layout
import Material.Options as Options
import Material.Icon as Icon
import Users.User exposing (User)

header : Model -> List (Html Msg)
header model =
        [ Layout.row
            [ Options.nop, Options.css "transition" "height 333ms ease-in-out 0s" ]
            [ Layout.title [] [ text "Study Buddy" ]
            , Layout.spacer
            , Layout.navigation []
                [ renderUserLinks model.user
                , Layout.link
                    [ Layout.href "https://www.elixir-lang.org" ]
                    [ Html.span [] [ text "Elixir" ] ]
                ]
            ]
        ]

renderUserLinks : Maybe User -> Html Msg
renderUserLinks maybeUser =
    case maybeUser of
        Just user ->
            Layout.link
                [ Options.onClick Msgs.Logout, Options.cs "pointer" ]
                [ Html.span [] [ text "Sign out" ] ]
        Nothing ->
            text ""