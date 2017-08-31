module Commands exposing (..)

import Http
import Json.Encode as Encode
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Jwt
import Msgs exposing (Msg)
import Users.User exposing (ApiUser)
import RemoteData

baseUrl : String
baseUrl =
  "http://localhost:4000/api/"

userDecoder : Decode.Decoder ApiUser
userDecoder =
  Decode.at ["data"]
    (decode ApiUser
      |> required "id" Decode.int
      |> required "username" Decode.string
      |> required "name" Decode.string
      |> required "email" Decode.string
    )

fetchUser : Maybe String -> Int -> Cmd Msg
fetchUser token userId =
  case token of
    Just token ->
      Jwt.get token (fetchUserUrl 1) userDecoder
      |> Jwt.send Msgs.OnLoadUser
    Nothing -> Cmd.none

fetchUserUrl : Int -> String
fetchUserUrl userId =
  baseUrl ++ "users/" ++ (toString userId)