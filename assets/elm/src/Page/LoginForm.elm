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
import Material.Card as Card
import Material.Color as Color
import Material.Button as Button
import Material.Options as Options
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


view : Form -> Material.Model -> Html.Html Msgs.Msg
view state mdl =
  Grid.grid [ Grid.align Grid.Middle ]
    [ Grid.cell
      [ Grid.size Grid.All 12
      , Typography.center
      , Options.center
      ]
      [ Card.view
        [ Options.css "border-radius" "1em"
        , Grid.size Grid.All 4
        , Color.background (Color.color Color.LightBlue Color.S500)
        , Options.css "color" "white"
        , Options.css "display" "flex"
        , Options.css "align-items" "center"
        ]
        [ Card.title
          [ Typography.center ]
          [ Card.head [ Options.css "color" "white" ] [ Html.text "Login" ]
          , Textfield.render Msgs.Mdl [0] mdl
            [ Textfield.label "Username"
            , Options.onInput (\char -> Msgs.SetUser char)
            , Textfield.floatingLabel
            ]
            [ ]
          , Textfield.render Msgs.Mdl [1] mdl
            [ Textfield.label "password"
            , Textfield.floatingLabel
            , Options.onInput (\char -> Msgs.SetPass char)
            , Textfield.password
            ]
            []
          , Html.br [] []
          , Button.render Msgs.Mdl [1, 0, 0, 0] mdl
            [ Button.ripple
            , Button.raised
            , Button.colored
            , Button.type_ "button"
            , Options.onClick Msgs.SubmitCredentials
            ]
            [ Html.text "Login" ]
          ]
        ]
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
    |> (Json.Decode.Pipeline.required "jwt" (Decode.maybe Decode.string))
