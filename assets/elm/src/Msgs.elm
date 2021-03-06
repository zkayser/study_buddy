module Msgs exposing (..)

import Page.LoginMsgs exposing (LoginMsg(..))
import Users.User exposing (User)
import Categories.Category exposing (Category, Subcategory)
import Http
import Jwt
import Flags exposing (LoginInfo)
import Material
import Navigation exposing (Location)
import RemoteData exposing (WebData)

type Msg
  = OnLocationChange Location
  | Mdl (Material.Msg Msg)
  | SetUser String
  | SetPass String
  | CategoryName String
  | SubmitCredentials
  | SubmitCategory
  | LoginResult (Result Http.Error LoginInfo)
  | Logout
  | OnLoadUser (Result Jwt.JwtError User)
  | OnLoadCategories (Result Jwt.JwtError (List Category))
  | ToggleSubcategories Category
  | ToggleTopics Subcategory

type alias Mdl =
        Material.Model
