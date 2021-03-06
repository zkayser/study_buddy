module Page.Layout exposing (..)

import Models exposing (Model)
import Msgs exposing (Msg(..), Mdl)
import Material.Layout as Layout
import Html exposing (..)
import Page.Header exposing (header)
import Page.Drawer exposing (drawer)
import Page.Body exposing (page)

layout : Model -> Html Msg
layout model =
        Layout.render Mdl model.mdl
        [ Layout.fixedHeader
        , Layout.fixedTabs
        , Layout.scrolling
        ]
          { header = Page.Header.header model 
          , drawer = Page.Drawer.drawer model
          , tabs = ([], []) 
          , main = [ Page.Body.page model ] 
        }
