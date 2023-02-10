module Domain.Room.Collection exposing (Collection(..), Internal, add, empty, get)

import Dict exposing (Dict)
import Domain.Room.Id as RoomId
import Domain.Room.Type exposing (RoomData)


type alias Internal =
    Dict String RoomData


type Collection
    = Internal Internal


empty : Collection
empty =
    Dict.empty |> Internal


open : Collection -> Internal
open (Internal rooms) =
    rooms


add : RoomData -> Collection -> Collection
add value (Internal collection) =
    Internal <|
        if Dict.member (RoomId.asString value.room.id) collection then
            collection

        else
            Dict.insert (RoomId.asString value.room.id) value collection


get : RoomId.RoomId -> Collection -> Maybe RoomData
get id =
    open >> Dict.get (RoomId.asString id)
