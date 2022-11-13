module Back.Main exposing (..)

import Dict exposing (Dict)
import Set exposing (Set)


type alias Model =
    Dict String Room


type alias Room =
    { mobbers : Set Mobber
    , name : String , id : String
    }


type alias Mobber =
    { id : String, name : String }
