module Categories.Category exposing (..)

import Exercises.Exercise exposing (Exercise)

type alias Category =
  { name : String
  , id : Int
  , subcategories : Maybe (List Subcategory)
  }

type alias Subcategory =
  { name : String
  , id : Int
  , topics : Maybe (List Topic)
  }

type alias Topic =
  { title : String
  , id : Int
  , exercises : Maybe (List Exercise)
  }   