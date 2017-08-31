module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Model)
import Page.LoginForm as Login exposing (submitCredentials, submitCredentialsCmd)
import Page.LoginFormHelpers as LoginHelpers
import Token exposing (storeToken, removeToken)
import Material
import Routing exposing (parseLocation)
import Commands exposing (fetchUser)
import RemoteData

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
            Msgs.OnLoadUser response ->
              ( model, Debug.log ("Got response: " ++ (toString response)) Cmd.none)
            Msgs.GetUser ->
              ( model, fetchUser model.jwt.jwt 1 )
            Msgs.OnLocationChange location ->
                    let
                        newRoute =
                                parseLocation location
                    in
                        ( { model | route = newRoute }, Cmd.none )
            Msgs.Mdl msg_ ->
                    Material.update Mdl msg_ model
            Msgs.SetUser username ->
              let
                loginForm =
                  model.loginForm
                updated =
                  { loginForm | username = username }
              in
                  ( { model | loginForm = updated }, Cmd.none )
            Msgs.SetPass password ->
              let
                loginForm =
                  model.loginForm
                updated =
                  { loginForm | password = password }
              in
              ( { model | loginForm = updated }, Cmd.none )
            Msgs.SubmitCredentials ->
              let
                loginForm =
                  model.loginForm
              in
                ( LoginHelpers.clearLoginForm model, (submitCredentialsCmd <| submitCredentials loginForm.username loginForm.password ))
            Msgs.LoginResult result ->
              case result of
                Ok token ->
                  ( { model | jwt = token }, storeToken token.jwt )
                Err errorMessage ->
                  ( { model | errorMessage = (toString errorMessage )}, Cmd.none)
            Msgs.Logout ->
              ( { model | jwt = {jwt = Nothing } }, removeToken Nothing )