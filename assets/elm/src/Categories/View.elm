module Categories.View exposing (..)

import Categories.Category exposing (Category, Subcategory, Topic, Categories)
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
        [ Grid.size Grid.All 12
        , Options.center
        , Typography.left
        ]
        (viewCategories model.categories)

viewCategories : Categories -> List (Html Msg)
viewCategories categories =
    case categories.categories of
        Nothing -> [ Html.text "" ]
        Just categoryList ->
            [ MaterialList.ul [ Options.cs "category-list" ]
               ( List.concat <| (List.map (viewCategory categories) categoryList)) ]

viewCategory : Categories -> Category -> List (Html Msg)
viewCategory categories category =
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
        if (categoryShouldBeRendered category categories) then
            (viewSubcategories category.subcategories categories)
        else 
            [ Html.text "" ] 

viewSubcategories : Maybe (List Subcategory) -> Categories -> List (Html Msg)
viewSubcategories maybeSubcategories categories =
    case maybeSubcategories of
        Nothing -> [ Html.text ""]
        Just subcategories -> 
            ( List.concat <| List.map (viewSubcategory categories) subcategories )

viewSubcategory : Categories -> Subcategory -> List (Html Msg)
viewSubcategory categories subcategory =
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
        if (subcatChildrenShouldBeRendered subcategory categories) then
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

categoryShouldBeRendered : Category -> Categories -> Bool
categoryShouldBeRendered category categories =
    case categories.selectedCategory of
        Nothing -> False
        Just cat ->
            cat.id == category.id && cat.childrenRendered

subcatChildrenShouldBeRendered : Subcategory -> Categories -> Bool
subcatChildrenShouldBeRendered subcat categories =
    case categories.selectedSubcategory of
        Nothing -> False
        Just subcategory ->
            subcategory.id == subcat.id && subcategory.childrenRendered
            