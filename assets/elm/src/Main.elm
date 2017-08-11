module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Material
import Material.Layout as Layout
import Material.Scheme
import Material.Icon as Icon
import Material.Button as Button
import Material.Options as Options exposing (..)
import Other exposing (..)

-- MODEL

-- You have to add a field to your model where you track the `Material.Model`
-- This is referred to as the "model container".
type alias Model =
  { count : Int
  , mdl : Material.Model
  -- Boilerplate: model store for any and all Mdl components you use
  }

-- `Material.Model` provides the initial model
model : Model
model =
  { count = 0
  , mdl = Material.model
  -- Always use this initial Mdl model store.
  }

-- ACTION, UPDATE

-- You need to tag `Msg` that are coming from `Mdl` so you can dispatch them
-- appropriately.
type Msg
  = Increase
  | Reset
  | Mdl (Material.Msg Msg)

-- Boilerplate: Msg clause for internal Mdl messages

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Increase ->
        ( { model | count = model.count + 1 }
        , Cmd.none
        )
    Reset ->
        ( { model | count = 0 }
        , Cmd.none
        )
    -- When the `Mdl` message comes through, update appropiately.
    Mdl msg_ ->
        Material.update Mdl msg_ model 

-- VIEW

type alias Mdl =
        Material.Model

view : Model -> Html Msg
view model =
        Layout.render Mdl model.mdl
        [ Layout.fixedHeader
        , Layout.fixedTabs
        , Layout.scrolling
        ]
          { header = header model 
          , drawer = [ text "This is the drawer" ]
          , tabs = ([ text "Some tabs" ], []) 
          , main = [ text "Some main content area stuff" ]
        }

header : Model -> List (Html Msg)
header model =
        [ Layout.row
            [ Options.nop, Options.css "transition" "height 333ms ease-in-out 0s" ]
            [ Layout.title [] [ text "Study Buddy" ]
            , Layout.spacer
            , Layout.navigation []
                [ Layout.link [] [ Icon.i "photo" ]
                , Layout.link
                [ Layout.href "https://www.github.com/zkayser" ]
                [ Html.span [] [ text "Github" ] ]
                , Layout.link
                [ Layout.href "https://www.elixir-lang.org" ]
                [ Html.span [] [ text "Elixir" ] ]
                ]
            ]
        ]
-- Load Google Mdl CSS. You'll likely want to do this not in code as is done here,
-- but rather in the master .html file. See the documentation for the `Material`
-- module for details.

main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Layout.sub0 Mdl )
        , view = view
        -- Here we add no subscriptions, but we'll need to use the 'Mdl' subscriptions for some components later.
        , subscriptions = \model -> Sub.batch [ Material.subscriptions Mdl model ]
        , update = update
        }
