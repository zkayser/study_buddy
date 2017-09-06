module Utils exposing (..)

import Html
import Html.Events as Events
import Json.Decode exposing (succeed)
import Jwt exposing (JwtError)

onClickPreventDefault : msg -> Html.Attribute msg
onClickPreventDefault msg =
   Events.onWithOptions "click"
    { stopPropagation = True
    , preventDefault = True
    }
    (succeed msg)

jwtErrorMessage : Jwt.JwtError -> String
jwtErrorMessage error =
    case error of
        Jwt.HttpError _ -> 
            "An error occurred during the request to the server. The server may be"
             ++ "down or under maintenance. Please try again."
        Jwt.Unauthorized ->
            "Sorry, but you cannot access the resource you are attempting to access."
        Jwt.TokenExpired ->
            "Your access token has grown stale! Please logout and log in again to reset."
        Jwt.TokenNotExpired ->
            "The token is not expired... Not sure what is happening with this error."
        Jwt.TokenProcessingError string ->
            string
        Jwt.TokenDecodeError string ->
            string