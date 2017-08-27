module Utils exposing (..)

import Html
import Html.Events as Events
import Json.Decode exposing (succeed)

onClickPreventDefault : msg -> Html.Attribute msg
onClickPreventDefault msg =
   Events.onWithOptions "click"
    { stopPropagation = True
    , preventDefault = True
    }
    (succeed msg)
