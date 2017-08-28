module Page.Home exposing (..)

import Users.User as User exposing (..)
import Msgs exposing (Msg(..))
import Page.LoginForm as LoginForm
import Html exposing (..)
import Html.Attributes exposing (type_)
import Utils exposing (onClickPreventDefault)
import RemoteData exposing (WebData)
import Material
import Material.Button as Button
import Material.Options as Options
import Material.Color as Color
import Material.Grid as Grid
import Material.Typography as Typography

view : (WebData User) -> LoginForm.Form -> Maybe String -> Material.Model -> Html Msg
view user form_ maybeToken mdl =
  case user of
    -- Should be the cases fir the WebData
    RemoteData.Loading ->
      Grid.grid [ Grid.align Grid.Middle ]
        [ Grid.cell
          [ Grid.offset Grid.All 4, Grid.size Grid.All 4, Typography.center ]
          [ Html.h3 [] [ text ("There are no users being loaded at the current time."
          ++ "\nPlease come back later.") ] ]
        ]
    RemoteData.Success user_ ->
      Grid.grid [ Grid.align Grid.Middle ]
        [ Grid.cell
          [ Grid.offset Grid.All 4, Grid.size Grid.All 4, Typography.center ]
          [ Html.h1 [] [ text ("Welcome to Study Buddy, " ++ User.fullName user_) ] ]
        ]
    RemoteData.Failure err ->
      Grid.grid [ Grid.align Grid.Middle ]
        [ Grid.cell
          [ Grid.offset Grid.All 4, Grid.size Grid.All 4, Typography.center ]
          [ Html.p [] [ text ("Something went wrong: " ++ (toString err)) ] ]
        ]
    RemoteData.NotAsked ->
      Grid.grid [ Grid.align Grid.Middle ]
        [ Grid.cell
          [ Grid.size Grid.All 12, Typography.center ]
          [ Html.h1 [] [ text "Welcome to Study Buddy." ]
          , Html.map Msgs.Login (LoginForm.view form_ )
          ]
        , Grid.cell
          [ Grid.size Grid.All 12, Typography.center ]
          [ Button.render Msgs.Mdl [0] mdl
            [ Button.raised
            , Options.css "color" "white"
            , Options.css "background-color" "blue"
            , Options.onClick Msgs.GetUser
            ]
            [ text "Get user" ]
          ]
          , renderLogoutButton maybeToken mdl
        ]

renderLogoutButton : Maybe String -> Material.Model -> Grid.Cell Msg
renderLogoutButton maybeToken mdl =
  case maybeToken of
    Just token ->
      Grid.cell
       [ Grid.size Grid.All 12, Typography.center ]
       [ Button.render Msgs.Mdl [1] mdl
        [ Button.raised
        , Options.css "color" "white"
        , Options.css "background-color" "red"
        , Options.onClick Msgs.Logout
        ]
        [ text "Logout" ]
       ]
    Nothing -> Grid.cell [] []
