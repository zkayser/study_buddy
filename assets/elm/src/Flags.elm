port module Flags exposing (..)

import Users.User exposing (User)
import Json.Decode exposing (Value)

type alias Flags =
  { token : Maybe String
  , user : Maybe User
  }

type alias LoginInfo =
    { jwt : Maybe String
    , userId : Maybe String 
    }

port storeToken : Maybe String -> Cmd msg

port logout : Maybe String -> Cmd msg

port storeUser : Maybe User -> Cmd msg

port removeUser : Maybe User -> Cmd msg 