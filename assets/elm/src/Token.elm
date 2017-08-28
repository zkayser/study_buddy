port module Token exposing (..)


type alias Token = { jwt : Maybe String }

port storeToken : Maybe String -> Cmd msg

port removeToken : Maybe String -> Cmd msg
