module Main exposing (..)

import Html exposing (..)
import Other exposing (..)

main =
  div []
  [   p [] [ text "Hello. I am a paragraph..." ]
    , p [] [ text "and I am from Elm." ]
    , Other.other
    , Other.yetAnother
  ]
