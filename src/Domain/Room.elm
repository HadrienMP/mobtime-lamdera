module Domain.Room exposing
    ( Room
    , RoomData
    )

import Domain.Mobbers as Mobbers
import Domain.RoomId exposing (RoomId)


type alias Room =
    { name : String
    , id : RoomId
    }


type alias RoomData =
    { room : Room
    , mobbers : Mobbers.Collection
    }
