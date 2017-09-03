module Page.LoginForm exposing (..)

import Html exposing (Html)
import Msgs exposing (Msg(..))
import Json.Encode as Encode
import Json.Decode as Decode exposing (..)
import Json.Decode.Pipeline exposing (required, optional)
import Http
import Flags exposing (LoginInfo)
import Users.User as User
import Material
import Material.Grid as Grid
import Material.Card as Card
import Material.Color as Color
import Material.Button as Button
import Material.Options as Options
import Material.Typography as Typography
import Material.Textfield as Textfield

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


view : Form -> Material.Model -> Grid.Cell Msg
view state mdl =
    Grid.cell
      [ Grid.size Grid.All 12
      , Typography.center
      , Options.center
      ]
      [ Card.view cardOptions
        [ Card.title
          [ Typography.center ]
          [ renderCardTitle 
            [ Options.css "align-self" "center"
            , Options.css "color" "white"
            ]
            "Login"
          , renderInputFieldFor "Username" [0] mdl Textfield.text_ Msgs.SetUser
          , renderInputFieldFor "Password" [1] mdl Textfield.password Msgs.SetPass
          , Html.br [] []
          , viewButton mdl [1, 0, 0, 0] "Login"
          ]
        ]
      ]

renderInputFieldFor : String -> List Int -> Material.Model -> Textfield.Property Msg -> (String -> Msg) -> Html Msg
renderInputFieldFor name mdlIndex mdl inputType msg =
  Textfield.render Msgs.Mdl mdlIndex mdl
    [ Textfield.label name
    , Textfield.floatingLabel
    , Options.onInput msg
    , inputType
    ]
    []

cardOptions : List (Options.Style Msg)
cardOptions =
  [ Options.css "border-radius" "1em"
  , Grid.size Grid.Phone 12
  , Grid.size Grid.Tablet 8
  , Grid.size Grid.Desktop 4
  , Color.background (Color.color Color.Cyan Color.S500)
  , Options.css "display" "flex"
  , Options.css "align-items" "center"
  ]

renderCardTitle : List (Options.Style Msg) -> String -> Html Msg
renderCardTitle styling title =
  Card.subhead styling
    [ Html.h2 [] [ Html.text title ] ]

viewButton : Material.Model -> List Int -> String -> Html Msg
viewButton mdl mdlIndex buttonTxt =
  Button.render Msgs.Mdl mdlIndex mdl
    [ Button.ripple
    , Button.raised
    , Button.colored
    , Button.type_ "button"
    , Options.css "align-self" "center"
    , Options.onClick Msgs.SubmitCredentials
    ]
    [ Html.text buttonTxt ]

submitCredentials : String -> String -> Http.Request LoginInfo 
submitCredentials username password =
  let
    body =
      [ ( "username", Encode.string username )
      , ( "password", Encode.string password )
      ]
      |> Encode.object
      |> Http.jsonBody
  in
    Http.post "http://localhost:4000/api/sessions" body loginInfoDecoder

submitCredentialsCmd : Http.Request LoginInfo -> Cmd Msgs.Msg
submitCredentialsCmd request =
  Http.send Msgs.LoginResult request

loginInfoDecoder : Decode.Decoder LoginInfo
loginInfoDecoder =
   Json.Decode.Pipeline.decode LoginInfo 
    |> (Json.Decode.Pipeline.required "jwt" (Decode.maybe Decode.string))
    |> (Json.Decode.Pipeline.required "id" (Decode.maybe Decode.string))
