module Evergreen.V1.Room exposing (..)

import Dict
import Evergreen.V1.Mobber


type alias Room =
    { name : String
    , id : String
    }


type alias RoomData =
    { room : Room
    , mobbers : Evergreen.V1.Mobber.Collection
    }


type alias Internal =
    Dict.Dict String RoomData


type Collection
    = Internal Internal
