module Categories.Commands exposing (..)

import Msgs exposing (Msg(..))
import Categories.Category exposing (Category)
import Categories.Decoder exposing (categoryListDecoder)
import Jwt
import Commands exposing (baseUrl)

fetchCategories : String -> Cmd Msg
fetchCategories jwt =
  Jwt.get jwt categoryListUrl categoryListDecoder
  |> Jwt.send Msgs.OnLoadCategories

categoryListUrl : String
categoryListUrl =
  baseUrl ++ "categories"