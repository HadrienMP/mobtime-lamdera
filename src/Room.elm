module Room exposing (Collection(..), Internal, Room, RoomData, add, emptyCollection)

import Dict exposing (Dict)
import Mobber


type alias Room =
    { name : String
    , id : String
    }


type alias RoomData =
    { room : Room
    , mobbers : Mobber.Collection
    }


type alias Internal =
    Dict String RoomData


type Collection
    = Internal Internal


emptyCollection : Collection
emptyCollection =
    Dict.empty |> Internal


open : Collection -> Internal
open rooms =
    case rooms of
        Internal internal ->
            internal


add : RoomData -> Collection -> Collection
add value =
    open >> Dict.insert value.room.id value >> Internal
