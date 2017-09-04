module Categories.Decoder exposing (..)

import Categories.Category exposing (Category, Subcategory, Topic)
import Exercises.Exercise exposing (exerciseDecoder)
import Json.Decode.Pipeline exposing (..)
import Json.Decode as Decode exposing (Decoder)

categoryListDecoder : Decoder (List Category)
categoryListDecoder =
    Decode.at [ "data" ] (Decode.list categoryDecoder)

categoryDecoder : Decoder Category
categoryDecoder =
  decode Category
    |> required "name" Decode.string
    |> required "id" Decode.int
    |> optional "subcategories" (Decode.maybe <| Decode.list subcategoryDecoder) Nothing

subcategoryDecoder : Decoder Subcategory
subcategoryDecoder =
  decode Subcategory
    |> required "name" Decode.string
    |> required "id" Decode.int
    |> optional "topics" (Decode.maybe <| Decode.list topicDecoder) Nothing

topicDecoder : Decoder Topic
topicDecoder =
  decode Topic
    |> required "title" Decode.string
    |> required "id" Decode.int
    |> optional "exercises" (Decode.maybe <| Decode.list exerciseDecoder) Nothing