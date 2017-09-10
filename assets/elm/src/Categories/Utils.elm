module Categories.Utils exposing (..)

import Models exposing (Model)
import Categories.Category exposing (Category, Categories, Subcategory)
import Jwt
import Utils exposing (jwtErrorMessage)

loadCategories : Model -> List Category -> Model
loadCategories model categoryList =
    let 
        categories =
            model.categories
        updatedCategories =
            { categories | categories = Just categoryList }
    in
        { model | categories = updatedCategories }

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
            let
                initialCats =
                    model.categories
                updatedCategories =
                    { initialCats | categories = Just categories }
            in       
                { model | categories = updatedCategories }
        Err error ->
            { model | errorMessage = jwtErrorMessage <| error }    

toggleDropdown : Model -> Category -> Model
toggleDropdown model category =
    let 
        categories =
            model.categories
        newSelected =
            compareSelectedWithCurrent categories.selectedCategory category
        updatedCategories =
            { categories | selectedCategory = Just (toggleChildren newSelected) }
    in
        { model | categories = updatedCategories }

toggleChildren : Category -> Category
toggleChildren category =
    { category | childrenRendered = not category.childrenRendered }

toggleSubcatDropdown : Model -> Subcategory -> Model
toggleSubcatDropdown model subcat =
    let
        categories =
            model.categories
        newSelected =
            compareSelectedSubcatWithCurrent categories.selectedSubcategory subcat
        updatedCategories =
            {categories | selectedSubcategory = Just (toggleSubcatChildren newSelected) }
    in
        { model | categories = updatedCategories }

toggleSubcatChildren : Subcategory -> Subcategory
toggleSubcatChildren subcat =
    { subcat | childrenRendered = not subcat.childrenRendered }

compareSelectedWithCurrent : Maybe Category -> Category -> Category
compareSelectedWithCurrent maybeCat cat =
    case maybeCat of
        Nothing -> cat
        Just selected ->
            if selected.id == cat.id then selected else cat

compareSelectedSubcatWithCurrent : Maybe Subcategory -> Subcategory -> Subcategory
compareSelectedSubcatWithCurrent maybeSubcat subcat =
    case maybeSubcat of
        Nothing -> subcat
        Just selected ->
            if selected.id == subcat.id then selected else subcat

resetCategories : Categories
resetCategories =
    { categories = Nothing
    , selectedCategory = Nothing
    , selectedSubcategory = Nothing
    }