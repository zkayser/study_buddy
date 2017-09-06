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
import Material.Typography as Typography

view : Model -> Grid.Cell Msg
view model =
    Grid.cell 
        [ Grid.size Grid.Desktop 6
        , Grid.size Grid.Tablet 6
        , Grid.size Grid.Phone 12
        , Options.center
        , Typography.left
        ]
        (viewCategories model.categories)

viewCategories : Maybe (List Category) -> List (Html Msg)
viewCategories categories =
    case categories of
        Nothing -> [ Html.text "" ]
        Just categories ->
            [ MaterialList.ul [ Options.cs "category-list" ]
               ( List.concat <| (List.map viewCategory categories)) ]

viewCategory : Category -> List (Html Msg)
viewCategory category =
    ([ MaterialList.li [ Options.cs "category-list-item"]
        [ MaterialList.content [ Options.onClick <| Msgs.ToggleSubcategories category ] 
            [ Html.text category.name ] 
            , MaterialList.content2 []
            [ MaterialList.info2 [] [ Html.text "New" ] 
            , Icon.view "info" [ Color.text Color.primary ]
            ]
        ]
    ])
    ++ 
        if category.childrenRendered == True then
            viewSubcategories category.subcategories
        else 
            [ Html.text "" ] 

viewSubcategories : Maybe (List Subcategory) -> List (Html Msg)
viewSubcategories maybeSubcategories =
    case maybeSubcategories of
        Nothing -> [ Html.text ""]
        Just subcategories -> 
            ( List.concat <| List.map viewSubcategory subcategories )

viewSubcategory : Subcategory -> List (Html Msg)
viewSubcategory subcategory =
    ([ MaterialList.li [ Options.cs "category-list-item" ]
        [ MaterialList.content [ Options.onClick <| Msgs.ToggleTopics subcategory ]
            [ Html.text subcategory.name ]
            , MaterialList.content2 []
            [ MaterialList.info2 [] [ Html.text "New" ]
            , Icon.view "info" [ Color.text Color.primary ]
            ]
        ] 
    ])
    ++
        if subcategory.childrenRendered == True then
            viewTopics subcategory.topics
        else 
            [ Html.text "" ]
    

viewTopics : Maybe (List Topic) -> List (Html Msg)
viewTopics maybeTopics =
    case maybeTopics of
        Nothing -> [ Html.text "" ]
        Just topics ->
            ( List.map viewTopic topics )

viewTopic : Topic -> Html Msg
viewTopic topic =
    MaterialList.li [ Options.cs "category-list-item" ]
        [ MaterialList.content []
            [ Html.text topic.title ]
            , MaterialList.content2 []
            [ MaterialList.info2 [] [ Html.text "New" ] 
            , Icon.view "info" [ Color.text Color.primary ]
            ]
        ]

{-
  <ul>Container
    <li>Parent Category
     --> Add this:
        <ul>Subcategory Container
            <li>Subcat1</li>
            <li>Subcat2</li>
        </ul>
    </li>
    <li>Another Parent Category</li>
    <li>And another</li>
  </ul>
-}    