module Users.User exposing (..)

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode

type alias User =
  { id : Int
  , username : String
  , name : String
  , email : String
  }

firstName : User -> String
firstName user =
  case List.take 1 (String.split " " user.name) of
    [first] -> first
    _ -> ""

lastName : User -> String
lastName user =
  case List.drop 1 (String.split " " user.name) of
    [last] -> last
    _ -> ""

initialUser : Maybe User
initialUser =
  Nothing

userDecoder : Decode.Decoder User
userDecoder =
  Decode.at ["data"]
    (decode User
      |> required "id" Decode.int
      |> required "username" Decode.string
      |> required "name" Decode.string
      |> required "email" Decode.string
    )

storedUserDecoder : Decode.Decoder User
storedUserDecoder =
  Decode.map4
    User
    (Decode.at [ "id" ] Decode.int)
    (Decode.at [ "username" ] Decode.string)
    (Decode.at [ "name" ] Decode.string)
    (Decode.at [ "email" ] Decode.string) 

encodeUser : User -> Encode.Value
encodeUser user =
  Encode.object
    [ ("id", Encode.int user.id)
    , ("username", Encode.string user.username)
    , ("name", Encode.string user.name)
    , ("email", Encode.string user.email)
    ]