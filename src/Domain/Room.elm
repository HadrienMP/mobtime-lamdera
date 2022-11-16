module Domain.Room exposing
    ( Room
    , RoomData
    )

import Domain.Mobber.Collection as Mobbers
import Domain.RoomId exposing (RoomId)


type alias Room =
    { name : String
    , id : RoomId
    }


type alias RoomData =
    { room : Room
    , mobbers : Mobbers.Collection
    }
