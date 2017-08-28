module Commands exposing (..)

import Http
import Json.Encode as Encode
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Jwt
import Msgs exposing (Msg)
import Players.Model exposing (PlayerId, Player)
import Users.User exposing (ApiUser)
import RemoteData

baseUrl : String
baseUrl =
  "http://localhost:4000/api/"

fetchPlayers : Cmd Msg
fetchPlayers =
        Http.get fetchPlayersUrl playersDecoder
            |> RemoteData.sendRequest
            |> Cmd.map Msgs.OnFetchPlayers

fetchPlayersUrl : String
fetchPlayersUrl =
        "http://localhost:4000/api/players"

fetchUserUrl : Int -> String
fetchUserUrl userId =
  baseUrl ++ "users/" ++ (toString userId)

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

playersDecoder : Decode.Decoder (List Player)
playersDecoder =
       Decode.at ["data"] (Decode.list playerDecoder)

playerDecoder : Decode.Decoder Player
playerDecoder =
        decode Player
            |> required "id" Decode.string
            |> required "name" Decode.string
            |> required "level" Decode.int

savePlayerUrl : PlayerId -> String
savePlayerUrl playerId =
        "http://localhost:4000/api/players/" ++ playerId

savePlayerRequest : Player -> Http.Request Player
savePlayerRequest player =
        Http.request
            { body = playerEncoder player |> Http.jsonBody
            , expect = Http.expectJson playerDecoder
            , headers = []
            , method = "POST"
            , timeout = Nothing
            , url = savePlayerUrl player.id
            , withCredentials = False
            }

savePlayerCmd : Player -> Cmd Msg
savePlayerCmd player =
        savePlayerRequest player
            |> Http.send Msgs.OnPlayerSave

playerEncoder : Player -> Encode.Value
playerEncoder player =
        let
            attributes =
                    [ ( "id", Encode.string player.id )
                    , ( "name", Encode.string player.name )
                    , ( "level", Encode.int player.level )
                    ]
        in
            Encode.object attributes
