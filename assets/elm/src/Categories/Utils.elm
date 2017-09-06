module Categories.Utils exposing (..)

import Models exposing (Model)
import Categories.Category exposing (Category)
import Jwt
import Utils exposing (jwtErrorMessage)

loadCategories : Model -> List Category -> Model
loadCategories model categoryList =
  { model | categories = Just categoryList }

addCategory : List Category -> Category -> List Category
addCategory categoryList newCategory =
  List.append categoryList [ newCategory ]

hideCategory : List Category -> Int -> List Category
hideCategory categoryList index =
  List.filter (\cat -> cat.id /= index) categoryList

handleCategoryLoad : Model -> Result Jwt.JwtError (List Category) -> Model
handleCategoryLoad model result =
    case result of
        Ok categories ->
            { model | categories = Just categories }
        Err error ->
            { model | errorMessage = jwtErrorMessage <| error }    

toggleDropdown : Model -> Category -> Model
toggleDropdown model category =
    let 
        newCategories =
            findAndUpdateCategories model.categories category
    in
        { model | categories = newCategories }

findAndUpdateCategories : Maybe (List Category) -> Category -> Maybe (List Category)
findAndUpdateCategories maybeCategories category =
    case maybeCategories of 
        Nothing -> Nothing
        Just categories ->
            let 
                theUpdatedCategory =
                    { category | childrenRendered = not category.childrenRendered }
                theNewCategories =
                    theUpdatedCategory :: (List.filter (\cat -> cat.id /= category.id) categories)
            in
                Just (List.sortBy .id theNewCategories)