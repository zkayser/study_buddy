module Page.LoginForm exposing (..)

import Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Msgs
import Json.Encode as Encode
import Json.Decode as Decode exposing (..)
import Json.Decode.Pipeline exposing (required, optional)
import Http
import Utils exposing (onClickPreventDefault)
import Token exposing (Token)
import Users.User as User
import Material
import Material.Grid as Grid
import Material.Typography as Typography
import Material.Textfield as Textfield
import Page.LoginMsgs as LoginMsg exposing (LoginMsg(..))

type alias Form =
    { username : String
    , password : String
    , rememberMe : Bool
    , forgotPassword : Bool
    }

initialLoginForm : Form
initialLoginForm =
    { username = ""
    , password = ""
    , rememberMe = False
    , forgotPassword = False
    }


update : LoginMsg -> Form -> ( Form, Cmd Msgs.Msg)
update msg form_ =
  case msg of
    LoginMsg.SetUsername char ->
      ( { form_ | username = char }, Cmd.none )
    LoginMsg.SetPassword char ->
      ( { form_ | password = char }, Cmd.none )
    LoginMsg.SubmitCredentials ->
      ( form_, (submitCredentialsCmd <| submitCredentials form_.username form_.password ))

view : Form -> Html.Html LoginMsg
view state =
  Grid.grid []
    [ Grid.cell
      [ Grid.offset Grid.All 4, Grid.size Grid.All 4, Typography.center ]
      [ Html.div [ style [ ("border", "1px black solid") ] ]
        [Html.form []
          [ Html.label [ style [("margin", "2px") ], for "username"] [ Html.text "Username" ]
          , Html.input [ Html.Attributes.value state.username, for "username", onInput LoginMsg.SetUsername ] []
          , Html.br [] []
          , Html.label [ style [("margin", "2px") ], for "password"] [ Html.text "Password" ]
          , Html.input [ Html.Attributes.value state.password
                       , for "password"
                       , type_ "password"
                       , onInput LoginMsg.SetPassword ] []
          ]
        ]
        , Html.br [] []
        , Html.button [ type_ "button", onClickPreventDefault SubmitCredentials ] [ Html.text "Login" ]
      ]
    ]

submitCredentials : String -> String -> Http.Request Token
submitCredentials username password =
  let
    body =
      [ ( "username", Encode.string username )
      , ( "password", Encode.string password )
      ]
      |> Encode.object
      |> Http.jsonBody
  in
    Http.post "http://localhost:4000/api/sessions" body tokenDecoder

submitCredentialsCmd : Http.Request Token -> Cmd Msgs.Msg
submitCredentialsCmd request =
  Http.send Msgs.LoginResult request

tokenDecoder : Decode.Decoder Token
tokenDecoder =
   Json.Decode.Pipeline.decode Token
    |> Json.Decode.Pipeline.required "jwt" Decode.string
