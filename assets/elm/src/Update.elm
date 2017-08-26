module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Model)
import Page.LoginForm as Login
import Material
import Routing exposing (parseLocation)
import Commands exposing (savePlayerCmd)
import Players.Model exposing (Player)
import RemoteData

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
            Msgs.OnFetchPlayers response ->
                    ( { model | players = response }, Cmd.none )
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
