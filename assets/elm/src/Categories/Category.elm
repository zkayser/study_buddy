module Categories.Category exposing (..)

import Exercises.Exercise exposing (Exercise)

type alias Category =
  { name : String
  , id : Int
  , subcategories : Maybe (List Subcategory)
  , childrenRendered : Bool
  }

type alias Subcategory =
  { name : String
  , id : Int
  , topics : Maybe (List Topic)
  , childrenRendered : Bool
  }

type alias Topic =
  { title : String
  , id : Int
  , exercises : Maybe (List Exercise)
  , childrenRendered : Bool
  }   