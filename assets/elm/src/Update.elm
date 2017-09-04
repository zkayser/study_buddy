module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Model)
import Users.User as User
import Page.LoginForm as Login exposing (submitCredentials, submitCredentialsCmd)
import Page.LoginFormHelpers as LoginHelpers exposing (LoginAttribute(..))
import Flags exposing (storeToken, logout, storeUser)
import Material
import Routing exposing (parseLocation)
import Commands exposing (fetchUser)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
      Msgs.OnLoadUser response ->
          case response of
            Ok user -> ( { model | user = Just user }, storeUser <| Just user )
            Err errorMessage -> ( { model | errorMessage = (toString errorMessage) }, Cmd.none )
      Msgs.OnLocationChange location ->
          let
            newRoute =
              parseLocation location
          in
            ( { model | route = newRoute }, Cmd.none )
      Msgs.OnLoadCategories result ->
        ( model, Debug.log ("Got result: " ++ (toString result)) Cmd.none )
      Msgs.Mdl msg_ ->
          Material.update Mdl msg_ model
      Msgs.SetUser username ->
          ( { model | loginForm = LoginHelpers.updateWith Username username model.loginForm }, Cmd.none )
      Msgs.SetPass password ->
          ( { model | loginForm = LoginHelpers.updateWith Password password model.loginForm }, Cmd.none )
      Msgs.SubmitCredentials ->
          LoginHelpers.login model
      Msgs.LoginResult result ->
          LoginHelpers.handleLoginResult model result
      Msgs.Logout ->
          ( { model | jwt = Nothing, user = Nothing }, logout Nothing ) 
        