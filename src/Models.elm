module Models exposing (Model, User, initialModel)


type alias Model =
    { email : String, username : String, password : String }


initialModel : Model
initialModel =
    { email = "", username = "", password = "" }
