module Categories.View exposing (..)

import Categories.Category exposing (Category, Subcategory, Topic)
import Models exposing (Model)
import Msgs exposing (Msg(..))
import Html exposing (Html)
import Html.Attributes exposing (..)
import Material
import Material.Grid as Grid
import Material.Options as Options
import Material.List as MaterialList
import Material.Icon as Icon
import Material.Color as Color

view : Model -> Grid.Cell Msg
view model =
    Grid.cell 
        [ Grid.size Grid.Desktop 6
        , Grid.size Grid.Tablet 6
        , Grid.size Grid.Phone 12
        , Options.center
        ]
        (viewCategories model.categories)

viewCategories : Maybe (List Category) -> List (Html Msg)
viewCategories categories =
    case categories of
        Nothing -> [ Html.text "" ]
        Just categories ->
            [ MaterialList.ul []
               (List.map viewCategory categories) ]

viewCategory : Category -> Html Msg
viewCategory category =
    MaterialList.li []
    [ MaterialList.content [] 
        [ Html.text category.name ] 
        , MaterialList.content2 []
        [ MaterialList.info2 [] [ Html.text "New" ] 
        , Icon.view "info" [ Color.text Color.primary ]
        ]
    ]