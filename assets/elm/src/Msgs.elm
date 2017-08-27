module Msgs exposing (..)

import Players.Model exposing (Player)
import Page.LoginMsgs exposing (LoginMsg(..))
import Users.User exposing (ApiUser)
import Http
import Jwt
import Token exposing (Token)
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
  | LoginResult (Result Http.Error Token)
  | Logout
  | OnLoadUser (Result Jwt.JwtError ApiUser)

type alias Mdl =
        Material.Model
