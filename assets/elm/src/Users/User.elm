module Users.User exposing (..)

type alias User =
  {   userId : Int
    , username : String
    , email : String
    , firstName : String
    , lastName : String
    , rememberMe : Bool
    , password : String
    , loggedIn : Bool
  }

type alias ApiUser =
  { id : Int
  , username : String
  , name : String
  , email : String
  }

type alias UserId =
        String

fullName : User -> String
fullName user =
  user.firstName ++ user.lastName
