module Page.LoginFormHelpers exposing (..)

import Models exposing (Model)

clearLoginForm : Model -> Model
clearLoginForm model =
  let
    loginForm =
      model.loginForm
    updated =
      { loginForm | username = "", password = "" }
  in
    { model | loginForm = updated }
