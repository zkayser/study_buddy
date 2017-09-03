module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Model)
import Users.User exposing (encodeUser)
import Page.LoginForm as Login exposing (submitCredentials, submitCredentialsCmd)
import Page.LoginFormHelpers as LoginHelpers
import Flags exposing (storeToken, logout, storeUser)
import Material
import Routing exposing (parseLocation)
import Commands exposing (fetchUser)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
            Msgs.OnLoadUser response ->
              case response of
                Ok user ->
                 ( { model | user = Just user }, storeUser <| Just user )
                Err errorMessage ->
              ( { model | errorMessage = (toString errorMessage) }, Cmd.none )
            Msgs.GetUser ->
              case model.user of
                Just user ->
                  ( model, fetchUser model.jwt (Just (toString <| user.id)))
                Nothing ->
                  ( model, Cmd.none )
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
                Ok loginInfo ->
                  ( { model | jwt = loginInfo.jwt }, Cmd.batch [(storeToken loginInfo.jwt), (fetchUser loginInfo.jwt loginInfo.userId)] )
                Err errorMessage ->
                  ( { model | errorMessage = (toString errorMessage )}, Cmd.none)
            Msgs.Logout ->
              ( { model | jwt = Nothing, user = Nothing }, logout Nothing ) 
              