port module Token exposing (..)


type alias Token = { jwt : String }

port storeToken : String -> Cmd msg

port removeToken : Maybe String -> Cmd msg
