module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Models exposing (initialModel, Model) -- Move Model type alias into Models and expose here
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
init : Location -> ( Model, Cmd Msg )
init location =
        let 
            currentLocation =
                Routing.parseLocation location
        in
            ( initialModel currentLocation, Cmd.batch [Layout.sub0 Mdl] )

main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init 
        , view = view
        , subscriptions = \model -> Sub.batch [ Material.subscriptions Mdl model ]
        , update = update
        }
