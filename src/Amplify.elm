port module Amplify exposing (errors, signup, signupSuccess)


port signup : { emailAddress : String, password : String, username : String } -> Cmd msg


port errors : (String -> msg) -> Sub msg


port signupSuccess : ({ username : String } -> msg) -> Sub msg
