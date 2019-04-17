module Pages exposing (authentication, emailInput, passwordAgain, passwordInput, usernameInput)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Models exposing (Model)


usernameInput : Html msg
usernameInput =
    div []
        [ i [] [ text "username" ]
        , input [ placeholder "EUsername", type_ "text" ] []
        ]


emailInput : Html msg
emailInput =
    div []
        [ i [] [ text "email" ]
        , input [ placeholder "Email", type_ "text" ] []
        ]


passwordInput : Html msg
passwordInput =
    div []
        [ i [] [ text "lock" ]
        , input [ placeholder "Password", type_ "password" ] []
        ]


passwordAgain : Html msg
passwordAgain =
    div []
        [ i [] [ text "lock" ]
        , input [ placeholder "Password Again", type_ "password" ] []
        ]


authentication : List (Html msg) -> Html msg
authentication body =
    main_ []
        [ div []
            [ Html.form []
                body
            ]
        ]



--signup : Model -> Html msg
--signup _ =
--    authentication
--        [ usernameInput
--        , emailInput
--        , passwordInput
--        , passwordAgain
--        , a [] [ text "Sign Upz" ]
--        ]
