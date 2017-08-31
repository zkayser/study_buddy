module Msgs exposing (..)

import Page.LoginMsgs exposing (LoginMsg(..))
import Users.User exposing (ApiUser)
import Http
import Jwt
import Token exposing (Token)
import Material
import Navigation exposing (Location)
import RemoteData exposing (WebData)

type Msg
  = OnLocationChange Location
  | Mdl (Material.Msg Msg)
  | SetUser String
  | SetPass String
  | SubmitCredentials
  | LoginResult (Result Http.Error Token)
  | Logout
  | OnLoadUser (Result Jwt.JwtError ApiUser)
  | GetUser

type alias Mdl =
        Material.Model
