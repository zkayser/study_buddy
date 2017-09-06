module Page.Home exposing (..)

import Users.User as User exposing (..)
import Msgs exposing (Msg(..))
import Page.LoginForm as LoginForm
import Categories.View as CategoryView
import Models exposing (Model)
import Html exposing (..)
import Utils exposing (onClickPreventDefault)
import Material
import Material.Button as Button
import Material.Options as Options
import Material.Color as Color
import Material.Grid as Grid
import Material.Typography as Typography

view : Model -> Html Msg
view model =  
  Grid.grid [ Grid.align Grid.Middle ]
    [ Grid.cell
      [ Grid.size Grid.All 12, Typography.center ]
      [ Html.h1 [] [ welcomeMessage model.user ] ]
    , (renderLoginForm model.jwt model.loginForm model.mdl )
    , (maybeRenderCategories model)
    ]



renderLoginForm : Maybe String -> LoginForm.Form -> Material.Model -> Grid.Cell Msg
renderLoginForm maybeToken form_ mdl =
  case maybeToken of
    Nothing -> LoginForm.view form_ mdl
    Just token -> Grid.cell [Options.css "display" "none" ] []

welcomeMessage : Maybe User -> Html Msg
welcomeMessage maybeUser =
  case maybeUser of
    Just user ->
      text ("Welcome to Study Buddy, " ++ (User.firstName user))
    Nothing ->
      text "Welcome to Study Buddy"

maybeRenderCategories : Model -> Grid.Cell Msg
maybeRenderCategories model =
  case model.categories of
    Nothing -> Grid.cell [Options.css "display" "none" ] []
    Just _ -> CategoryView.view model