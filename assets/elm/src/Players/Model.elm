module Players.Model exposing (..)

import RemoteData exposing (WebData)

type alias Player =
  { id : PlayerId
  , name : String
  , level : Int
  }

type alias PlayerId = String
