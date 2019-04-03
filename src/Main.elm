module Main exposing (..)

import Browser
import Html exposing (Html, input, text, br, div, h1, button, label)
import Html.Events exposing (onClick)

---- MODEL ----

type Model
 = LoggedOut

initialModel : Model
initialModel =
 LoggedOut

init : ( Model, Cmd Msg )
init =
 ( initialModel, Cmd.none )

---- UPDATE ----

type Msg
  = DoSignUp

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case model of
      LoggedOut  ->
          case msg of
              DoSignUp ->
                  ( model, Cmd.none )

---- VIEW ----

view : Model -> Html Msg
view model =
 case model of
     LoggedOut ->
         div []
             [ h1 [] [ text "Welcome! Please sign up." ]
             , button
                 [ onClick (DoSignUp) ]
                 [ text "Sign up" ]
             ]

---- PROGRAM ----

main : Program () Model Msg
main =
  Browser.element
      { view = view
      , init = \_ -> init
      , update = update
      , subscriptions = always Sub.none
      }