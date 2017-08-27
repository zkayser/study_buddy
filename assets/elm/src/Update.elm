module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Model)
import Page.LoginForm as Login
import Token exposing (storeToken, removeToken)
import Material
import Routing exposing (parseLocation)
import Commands exposing (savePlayerCmd, fetchUser)
import Players.Model exposing (Player)
import RemoteData

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
            Msgs.OnFetchPlayers response ->
                    ( { model | players = response }, Cmd.none )
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
            Msgs.ChangeLevel player howMuch ->
                    let updatedPlayer =
                                { player | level = player.level + howMuch }
                    in
                        ( model, savePlayerCmd updatedPlayer )
            Msgs.OnPlayerSave (Ok player) ->
                    ( updatePlayer model player, Cmd.none )
            Msgs.OnPlayerSave (Err error) ->
                    ( model, Cmd.none )
            Msgs.Mdl msg_ ->
                    Material.update Mdl msg_ model
            Msgs.Login msg_ ->
              let
                ( form, cmd ) =
                  Login.update msg_ model.loginForm
              in
               ( { model | loginForm = form }, cmd)
            Msgs.LoginResult result ->
              case result of
                Ok token ->
                  ( { model | jwt = token }, storeToken token.jwt )
                Err errorMessage ->
                  ( { model | errorMessage = (toString errorMessage )}, Cmd.none)
            Msgs.Logout ->
              ( model, removeToken Nothing )

updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
        let
            pick currentPlayer =
                    if updatedPlayer.id == currentPlayer.id then
                            updatedPlayer
                    else
                            currentPlayer
            updatePlayerList players =
                    List.map pick players
            updatedPlayers =
                    RemoteData.map updatePlayerList model.players
        in
            { model | players = updatedPlayers }
