module Msgs exposing (..)

import Page.LoginMsgs exposing (LoginMsg(..))
import Users.User exposing (User)
import Http
import Jwt
import Flags exposing (LoginInfo)
import Material
import Navigation exposing (Location)
import RemoteData exposing (WebData)

type Msg
  = OnLocationChange Location
  | Mdl (Material.Msg Msg)
  | SetUser String
  | SetPass String
  | SubmitCredentials
  | LoginResult (Result Http.Error LoginInfo)
  | Logout
  | OnLoadUser (Result Jwt.JwtError User)

type alias Mdl =
        Material.Model
