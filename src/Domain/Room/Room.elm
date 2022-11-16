module Domain.Room.Room exposing
    ( Room
    , RoomData
    )

import Domain.Mobber.Collection as Mobbers
import Domain.Room.RoomId exposing (RoomId)


type alias Room =
    { name : String
    , id : RoomId
    }


type alias RoomData =
    { room : Room
    , mobbers : Mobbers.Collection
    }
