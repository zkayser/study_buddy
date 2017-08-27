module Page.LoginMsgs exposing (..)

import Http

type LoginMsg
  = SetUsername String
  | SetPassword String
  | SubmitCredentials
