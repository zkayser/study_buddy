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
        updatedCategories =
            { categories | selectedCategory = Just (toggleChildren category) }
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
        updatedCategories =
            {categories | selectedSubcategory = Just (toggleSubcatChildren subcat) }
    in
        { model | categories = updatedCategories }

toggleSubcatChildren : Subcategory -> Subcategory
toggleSubcatChildren subcat =
    { subcat | childrenRendered = not subcat.childrenRendered }
