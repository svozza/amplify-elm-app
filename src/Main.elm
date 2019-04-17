module Main exposing (main)

--import Models exposing (..)
--import Models exposing (Model)

import Amplify
import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode
import Url


type alias Model =
    { email : String
    , username : String
    , password : String
    , key : Nav.Key
    , url : Url.Url
    , loggedIn : Bool
    }


type Msg
    = DoSignUp
    | UrlChanged Url.Url
    | LinkClicked Browser.UrlRequest
    | SetField FormField String
    | AmplifyError String
    | AmplifySignupSuccess


type FormField
    = Email
    | Password
    | Username


setField : FormField -> String -> Model -> Model
setField field value model =
    case field of
        Email ->
            { model | email = value }

        Password ->
            { model | password = value }

        Username ->
            { model | username = value }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "updatezz" msg of
        SetField field value ->
            ( setField field value model, Cmd.none )

        DoSignUp ->
            ( model
            , Amplify.signup
                { emailAddress = model.email
                , password = model.password
                , username = model.username
                }
            )

        AmplifyError _ ->
            ( model, Cmd.none )

        AmplifySignupSuccess ->
            ( { model | password = "", loggedIn = True }, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )


type Page
    = Home
    | SignIn
    | Signup
    | NotFound


parseUrlToPage : Url.Url -> Page
parseUrlToPage url =
    let
        urlString =
            Debug.log "url" (Url.toString url)
    in
    if String.contains "/home" urlString then
        Home

    else if String.contains "/signup" urlString then
        Signup

    else
        NotFound


view : Model -> Browser.Document Msg
view model =
    case parseUrlToPage model.url of
        Home ->
            home model

        SignIn ->
            signIn model

        Signup ->
            signup model

        NotFound ->
            notFound model


onEnter : msg -> Attribute msg
onEnter msg =
    keyCode
        |> Decode.andThen
            (\key ->
                if key == 13 then
                    Decode.succeed msg

                else
                    Decode.fail "Not enter"
            )
        |> on "keyup"


signup : Model -> Browser.Document Msg
signup model =
    { title = "Signup"
    , body =
        [ div
            [ onEnter DoSignUp ]
            [ label []
                [ text "Username"
                , input
                    [ type_ "text"
                    , placeholder "Username"
                    , onInput <| SetField Username
                    , value model.username
                    ]
                    []
                ]
            , label []
                [ text "Email"
                , input
                    [ type_ "text"
                    , placeholder "Email"
                    , onInput <| SetField Email
                    , value model.email
                    ]
                    []
                ]
            , label []
                [ text "Password"
                , input
                    [ type_ "password"
                    , placeholder "Password"
                    , onInput <| SetField Password
                    , value model.password
                    ]
                    []
                ]
            , button
                [ onClick DoSignUp ]
                [ text "Submit" ]
            ]
        ]
    }


signIn : Model -> Browser.Document Msg
signIn model =
    { title = "Sign In"
    , body =
        [ div
            [ onEnter DoSignUp ]
            [ label []
                [ text "Username"
                , input
                    [ type_ "text"
                    , placeholder "Username"
                    , onInput <| SetField Username
                    , value model.username
                    ]
                    []
                ]
            , label []
                [ text "Password"
                , input
                    [ type_ "password"
                    , placeholder "Password"
                    , onInput <| SetField Password
                    , value model.password
                    ]
                    []
                ]
            , button
                [ onClick DoSignUp ]
                [ text "Submit" ]
            ]
        ]
    }


home : Model -> Browser.Document Msg
home model =
    { title = "Home"
    , body =
        [ div
            []
            [ p [] [ text ("Email: " ++ model.email) ] ]
        ]
    }


notFound : Model -> Browser.Document Msg
notFound model =
    { title = "Home"
    , body =
        [ div
            []
            [ p [] [ text "Not Found" ] ]
        ]
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model "" "" "/signup" key url False, Cmd.none )


main : Program () Model Msg
main =
    Browser.application
        { view = view
        , init = init
        , update = update
        , subscriptions =
            \model ->
                Sub.batch
                    [ Amplify.signupSuccess AmplifySignupSuccess
                    , Amplify.errors AmplifyError
                    ]
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }
