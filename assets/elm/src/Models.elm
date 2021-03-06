module Models exposing (..)

import Flags exposing (Flags)
import Users.User as User exposing (..)
import Categories.Category exposing (Categories, initialCategories)
import Page.LoginForm as LoginForm
import Json.Decode as Decode
import Commands
import Material

type alias Model =
        { mdl : Material.Model
        , user :  Maybe User
        , categories : Categories
        , route : Route
        , loginForm : LoginForm.Form
        , jwt : Maybe String 
        , errorMessage : String
        }

initialModel : Flags -> Route -> Model
initialModel flags route =
  let
    tkn = flags.token
    initialUser = flags.user
  in
    { mdl = Material.model
    , route = Debug.log ("Route = " ++ (toString route))route
    , user = initialUser
    , categories = initialCategories
    , loginForm = LoginForm.initialLoginForm
    , jwt = tkn
    , errorMessage = ""
    }

type Route
    = HomeRoute
    | CategoriesRoute Int
    | NewCategoryRoute String
    | TopicsRoute Int
    | ExercisesRoute Int
    | NotFoundRoute
