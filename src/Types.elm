module Types exposing
    ( BackendModel
    , BackendMsg(..)
    , EntryRequest
    , FrontendModel
    , FrontendMsg
    , ToBackend(..)
    , ToFrontend(..)
    )

import Frontend.Types
import Domain.Room as Room
import Domain.Rooms as Rooms
import Domain.Mobber exposing (Mobber)
import Domain.Room exposing (Room)


type alias FrontendModel =
    Frontend.Types.Model


type alias FrontendMsg
    = Frontend.Types.Msg


type ToBackend
    = CreateRoom EntryRequest



-- Backend


type alias BackendModel =
    Rooms.Collection


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = UnknownRoom
    | EntryGranted Room.RoomData Mobber


type alias EntryRequest =
    { room : Room, mobber : Mobber }
