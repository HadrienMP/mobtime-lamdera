module Room exposing (..)

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


get : String -> Collection -> Maybe RoomData
get id =
    open >> Dict.get id


replace : String -> RoomData -> Collection -> Collection
replace id value =
    open
        >> Dict.update id (always <| Just value)
        >> Internal


add : RoomData -> Collection -> Collection
add value =
    open >> Dict.insert value.room.id value >> Internal
