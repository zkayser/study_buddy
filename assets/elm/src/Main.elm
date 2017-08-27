module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Models exposing (initialModel, Model, Flags)
import Msgs exposing (Msg(..))
import View exposing (..)
import Update exposing (update)
import Page.Header exposing (header)
import Array
import Material
import Material.Layout as Layout
import Material.Grid as Grid
import Material.Color as Color
import Material.Scheme
import Material.Icon as Icon
import Material.Button as Button
import Material.Typography as Typography
import Material.Options as Options exposing (..)
import Other exposing (..)
import Navigation exposing (Location)
import Routing

-- Maybe move this function into Models?
init : Flags -> Location -> ( Model, Cmd Msg )
init flags location =
        let
            currentLocation =
                Routing.parseLocation location

        in
            ( initialModel flags currentLocation, Cmd.batch [Layout.sub0 Mdl] )

main : Program Flags Model Msg
main =
    Navigation.programWithFlags Msgs.OnLocationChange
        { init = init
        , view = view
        , subscriptions = \model -> Sub.batch [ Material.subscriptions Mdl model ]
        , update = update
        }
