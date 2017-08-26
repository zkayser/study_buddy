module Msgs exposing (..)

import Players.Model exposing (Player)
import Page.LoginMsgs exposing (LoginMsg(..))
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
  | Login (LoginMsg)

type alias Mdl =
        Material.Model
