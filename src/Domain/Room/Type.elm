module Domain.Room.Type exposing
    ( Room
    , RoomData
    )

import Domain.Mobber.Collection as Mobbers
import Domain.Room.Id exposing (RoomId)


type alias Room =
    { name : String
    , id : RoomId
    }


type alias RoomData =
    { room : Room
    , mobbers : Mobbers.Collection
    }
