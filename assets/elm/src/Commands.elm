module Commands exposing (..)

import Json.Decode as Decode
import Jwt
import Msgs exposing (Msg)
import Users.User exposing (User, userDecoder)

baseUrl : String
baseUrl =
  "http://localhost:4000/api/"

fetchUser : Maybe String -> Maybe String -> Cmd Msg
fetchUser token userId =
  let
    tkn =
      case token of
        Just token -> token
        _ -> "" 
    id =
      case userId of
        Just userId -> userId
        _ -> "" 
  in
    case [tkn, id] of
      ["", ""] -> Cmd.none
      [tkn, id] -> 
        Jwt.get tkn (fetchUserUrl id) userDecoder
        |> Jwt.send Msgs.OnLoadUser
      _ -> Cmd.none

fetchUserUrl : String -> String
fetchUserUrl userId =
  baseUrl ++ "users/" ++ userId