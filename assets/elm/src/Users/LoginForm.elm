module LoginForm exposing (..)

type alias Model =
    { loggedIn : Bool
    , username : String
    , password : String
    , rememberMe : Bool
    , forgotPassword : Bool
    }

initialModel : Model
initialModel =
    { loggedIn = checkLoggedIn
    , username = ""
    , password = ""
    , rememberMe = checkRememberMe
    , forgotPassword = False
    }

checkLoggedIn : Bool
checkLoggedIn =
    -- Return False for now
    False

checkRememberMe : Bool
checkRememberMe =
    -- Return False for now
    False


