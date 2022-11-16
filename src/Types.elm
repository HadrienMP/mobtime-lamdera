module Types exposing
    ( BackendModel
    , BackendMsg(..)
    , EntryRequest
    , FrontendModel
    , FrontendMsg
    , ToBackend(..)
    , ToFrontend(..)
    )

import Domain.Mobber.Type exposing (Mobber)
import Domain.Room.Room as Room exposing (Room)
import Domain.Room.Rooms as Rooms
import Frontend.Types


type alias FrontendModel =
    Frontend.Types.Model


type alias FrontendMsg =
    Frontend.Types.Msg


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
