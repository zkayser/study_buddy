module Main exposing (..)

import Models exposing (initialModel, Model)
import Flags exposing (Flags)
import Msgs exposing (Msg(..))
import View exposing (..)
import Categories.Commands exposing (fetchCategories)
import Update exposing (update)
import Material
import Material.Layout as Layout
import Navigation exposing (Location)
import Routing

init : Flags -> Location -> ( Model, Cmd Msg )
init flags location =
  let
      currentLocation =
          Routing.parseLocation location
      jwt =
        case flags.token of
          Nothing -> ""
          Just token -> token
      cmd =
        if flags.user == Nothing then Cmd.none else fetchCategories jwt
  in
      ( initialModel flags currentLocation, Cmd.batch [Layout.sub0 Mdl, cmd] )

main : Program Flags Model Msg
main =
  Navigation.programWithFlags Msgs.OnLocationChange
      { init = init
      , view = view
      , subscriptions = \model -> Sub.batch [ Material.subscriptions Mdl model ]
      , update = update
      }
