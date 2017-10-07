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

type alias Categories =
  { categories : Maybe (List Category)
  , selectedCategory : Maybe Category
  , selectedSubcategory : Maybe Subcategory
  }

type CategoryFormState
  = Empty
  | Populated Category

initialCategories : Categories
initialCategories =
  { categories = Nothing
  , selectedCategory = Nothing
  , selectedSubcategory = Nothing
  }

emptyCategory : Category
emptyCategory =
  { name = ""
  , id = 0
  , subcategories = Nothing
  , childrenRendered = False
  }

emptySubcategory : Subcategory
emptySubcategory =
  { name = ""
  , id = 0
  , topics = Nothing
  , childrenRendered = False
  }