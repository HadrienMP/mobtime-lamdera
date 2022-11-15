module Model exposing (..)
import Lib.AutoDict exposing (AutoDict)


type alias Room =
    { name : String
    , id : String
    }


type alias RoomData =
    { room : Room
    , mobbers : AutoDict String Mobber
    }


type alias Mobber =
    { id : String, name : String }
