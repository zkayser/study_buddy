module Categories.View exposing (..)

import Categories.Category exposing (Category, Subcategory, Topic, Categories, CategoryFormState(..))
import Models exposing (Model, Route(..))
import Msgs exposing (Msg(..))
import Html exposing (Html)
import Html.Attributes exposing (..)
import Material
import Material.Grid as Grid
import Material.Options as Options
import Material.List as MaterialList
import Material.Textfield as Textfield
import Material.Button as Button
import Material.Card as Card
import Material.Icon as Icon
import Material.Color as Color
import Material.Layout as Layout
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
            [ Html.a [ href ("categories/" ++ (toString category.id)) ] [ Html.text category.name ] ]
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
            [ Html.a [ href ("categories/" ++ (toString subcategory.id)) ] [ Html.text subcategory.name ] ]
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
            [ Html.a [ href ("topics/" ++ (toString topic.id)) ] [ Html.text topic.title ] ]
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

categoryShowView : Model -> Html Msg
categoryShowView model =
    Grid.grid
        [ Grid.size Grid.All 12 
        , Options.center
        , Typography.center
        ]
        [ (categoryForm model )]

createCategoryView : Model -> Html Msg
createCategoryView model =
    Grid.grid 
        [ Grid.size Grid.All 12
        , Options.center
        , Typography.center
        ]
        [ (categoryForm model Categories.Category.Empty) ]

categoryForm : Model -> CategoryFormState -> Grid.Cell Msg
categoryForm model state =
    case state of
        Categories.Category.Empty ->
            Grid.cell
                [ Grid.size Grid.All 12
                , Typography.center
                , Options.center
                ]
                [ Card.view cardOptions
                    [ Card.title 
                        [ Typography.center ]
                        [ renderCardTitle
                            [ Options.css "align-self" "center"
                            , Options.css "color" "white"
                            ]
                            "New Category"
                        , renderInputFieldFor "Category" [2] model.mdl Textfield.text_ Msgs.CategoryName
                        , Html.br [] []
                        , viewButton model.mdl [2, 0, 0, 0] "Create Category"
                        ]
                    ]
                ]
        Categories.Category.Populated category ->
            Grid.cell [ Grid.size Grid.All 0 ] [ Html.text "" ]

cardOptions : List (Options.Style Msg)
cardOptions =
  [ Options.css "border-radius" "1em"
  , Grid.size Grid.Phone 12
  , Grid.size Grid.Tablet 8
  , Grid.size Grid.Desktop 4
  , Color.background (Color.color Color.Cyan Color.S500)
  , Options.css "display" "flex"
  , Options.css "align-items" "center"
  ]

renderCardTitle : List (Options.Style Msg) -> String -> Html Msg
renderCardTitle styling title =
  Card.subhead styling
    [ Html.h2 [] [ Html.text title ] ]

renderInputFieldFor : String -> List Int -> Material.Model -> Textfield.Property Msg -> (String -> Msg) -> Html Msg
renderInputFieldFor name mdlIndex mdl inputType msg =
  Textfield.render Msgs.Mdl mdlIndex mdl
    [ Textfield.label name
    , Textfield.floatingLabel
    , Options.onInput msg
    , inputType
    ]
    []

viewButton : Material.Model -> List Int -> String -> Html Msg
viewButton mdl mdlIndex buttonTxt =
  Button.render Msgs.Mdl mdlIndex mdl
    [ Button.ripple
    , Button.raised
    , Button.colored
    , Button.type_ "button"
    , Options.css "align-self" "center"
    , Options.onClick Msgs.SubmitCategory
    ]
    [ Html.text buttonTxt ]