module Exercises.Exercise exposing (..)

import Date exposing (Date)
import Json.Decode.Pipeline exposing (..)
import Json.Decode as Decode exposing (Decoder)

type alias Exercise =
  { type_ : String
  , task : String
  , answer : String
  , reviews : Int
  , successes : Int
  , failures : Int
  , isDue : Bool
  , lastReview : String
  , nextReview : String
  , source : String
  , mastered : Bool
  }

exerciseDecoder : Decoder Exercise
exerciseDecoder =
  decode Exercise
    |> required "type" Decode.string
    |> required "task" Decode.string
    |> required "answer" Decode.string
    |> optional "reviews" Decode.int 0
    |> optional "successes" Decode.int 0
    |> optional "failures" Decode.int 0
    |> optional "is_due?" Decode.bool True
    |> optional "last_review" Decode.string ""
    |> optional "next_review" Decode.string ""
    |> optional "source" Decode.string ""
    |> optional "mastered" Decode.bool False