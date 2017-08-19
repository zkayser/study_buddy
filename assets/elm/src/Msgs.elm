module Msgs exposing (..)

import Models exposing (Player)
import Http
import Material
import Navigation exposing (Location)
import RemoteData exposing (WebData)

type Msg
  = OnFetchPlayers (WebData (List Player))
  | OnLocationChange Location
  | ChangeLevel Player Int
  | OnPlayerSave (Result Http.Error Player)
  | Mdl (Material.Msg Msg)

type alias Mdl =
        Material.Model
