module Categories.Utils exposing (..)

import Models exposing (Model)

loadCategories : Model -> List Category -> Model
loadCategories model categoryList =
  { model | categories = categoryList }

addCategory : List Category -> Category -> List Category
addCategory categoryList newCategory =
  List.append categoryList newCategory

hideCategory : List Category -> Int -> List Category
hideCategory categoryList index =
  List.filter (.id /= index) categoryList