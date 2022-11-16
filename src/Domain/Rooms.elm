module Domain.Rooms exposing (Collection(..), Internal, add, emptyCollection)

import Dict exposing (Dict)
import Domain.Room exposing (RoomData)
import Domain.RoomId as RoomId


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
    open >> Dict.insert (RoomId.open value.room.id) value >> Internal
