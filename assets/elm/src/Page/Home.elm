module Page.Home exposing (..)

import Users.User as User exposing (..)
import Msgs exposing (Msg(..))
import Html exposing (..)
import RemoteData exposing (WebData)
import Material
import Material.Color as Color
import Material.Grid as Grid
import Material.Typography as Typography

view : (WebData User) -> Html Msg
view user =
  case user of
    -- Should be the cases fir the WebData
    RemoteData.Loading ->
      text "Loading..."
    RemoteData.Success user_ ->
      Grid.grid [ Grid.align Grid.Middle ]
        [ Grid.cell 
          [ Grid.offset Grid.All 4, Grid.size Grid.All 4, Typography.center ]
          [ Html.h1 [] [ text ("Welcome to Study Buddy, " ++ User.full_name user_) ] ]
        ]
    RemoteData.Failure err ->
      Grid.grid [ Grid.align Grid.Middle ]
        [ Grid.cell
          [ Grid.offset Grid.All 4, Grid.size Grid.All 4, Typography.center ]
          [ Html.p [] [ text ("Something went wrong: " ++ (toString err)) ] ]
        ]
    RemoteData.NotAsked ->
      Grid.grid [ Grid.align Grid.Middle ]
        [ Grid.cell
          [ Grid.offset Grid.All 4, Grid.size Grid.All 4, Typography.center ]
          [ Html.h1 [] [ text "Welcome to Study Buddy. You are not logged in (yet)." ] ]
        ]

