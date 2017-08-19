module Users.User exposing (..)

type alias User =
  { id : String 
  , username : String
  , email : String
  , first_name : String
  , last_name : String
  , remember_me : Bool
  , password : String
  , logged_in : Bool
  }

type alias UserId =
        String

full_name : User -> String
full_name user =
  user.first_name ++ user.last_name


