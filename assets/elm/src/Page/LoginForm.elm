module Page.LoginForm exposing (..)

import Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
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


update : LoginMsg -> Form -> ( Form, Cmd msg )
update msg form_ =
  case msg of
    LoginMsg.SetUsername char ->
      ( { form_ | username = char }, Cmd.none )
    LoginMsg.SetPassword char ->
      ( { form_ | password = char }, Cmd.none )
    LoginMsg.SubmitCredentials ->
      ( form_, submitCredentials form_.username form_.password )

view : Form -> Html.Html LoginMsg
view state =
  Grid.grid []
    [ Grid.cell
      [ Grid.offset Grid.All 4, Grid.size Grid.All 4, Typography.center ]
      [ Html.div [ style [ ("border", "1px black solid") ] ]
        [Html.form []
          [ Html.label [ style [("margin", "2px") ], for "username"] [ Html.text "Username" ]
          , Html.input [ value state.username, for "username", onInput LoginMsg.SetUsername ] []
          , Html.br [] []
          , Html.label [ style [("margin", "2px") ], for "password"] [ Html.text "Password" ]
          , Html.input [ value state.password
                       , for "password"
                       , type_ "password"
                       , onInput LoginMsg.SetPassword ] []
          ]
        ]
      ]
    ]

submitCredentials : String -> String -> Cmd msg
submitCredentials username password =
  -- Return nothing for the time being
  Cmd.none
