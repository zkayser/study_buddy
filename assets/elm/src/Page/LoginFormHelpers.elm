module Page.LoginFormHelpers exposing (..)

import Models exposing (Model)
import Msgs exposing (Msg(..))
import Page.LoginForm as LoginForm exposing (submitCredentialsCmd, submitCredentials)
import Flags exposing (storeToken, logout, storeUser, LoginInfo)
import Categories.Commands exposing (fetchCategories)
import Commands exposing (fetchUser)

type LoginAttribute
  = Username
  | Password

clearLoginForm : Model -> Model
clearLoginForm model =
  let
    loginForm =
      model.loginForm
    updated =
      { loginForm | username = "", password = "" }
  in
    { model | loginForm = updated }

updateWith : LoginAttribute -> String -> LoginForm.Form -> LoginForm.Form
updateWith attr letter loginForm =
  case attr of
    Username -> { loginForm | username = letter }
    Password -> { loginForm | password = letter }

login : Model -> ( Model, Cmd Msg )
login model =
  let
    loginForm =
      model.loginForm
  in
    ( clearLoginForm model, (submitCredentialsCmd <| submitCredentials loginForm.username loginForm.password))

handleLoginResult : Model -> Result error LoginInfo -> (Model, Cmd Msg)
handleLoginResult model result =
  case result of
    Ok loginInfo ->
      ( { model | jwt = loginInfo.jwt }, Cmd.batch (loginCommands loginInfo) )
    Err errorMessage ->
      ( { model | errorMessage = (toString errorMessage) }, Cmd.none )

loginCommands : LoginInfo -> List (Cmd Msg)
loginCommands loginInfo =
  let
    loginCommands =
      [ (storeToken loginInfo.jwt)
      , (fetchUser loginInfo.jwt loginInfo.userId)
      ]
  in
    case loginInfo.jwt of
      Nothing -> loginCommands
      Just jwt -> loginCommands ++ [(fetchCategories jwt)]
      
  
    