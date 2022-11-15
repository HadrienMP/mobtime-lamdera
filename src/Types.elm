module Types exposing
    ( BackendModel
    , BackendMsg(..)
    , EntryRequest
    , FrontendModel
    , FrontendMsg
    , ToBackend(..)
    , ToFrontend(..)
    )

import Front.Types
import Room
import Mobber exposing (Mobber)
import Room exposing (Room)


type alias FrontendModel =
    Front.Types.Model


type alias FrontendMsg
    = Front.Types.Msg


type ToBackend
    = CreateRoom EntryRequest



-- Backend


type alias BackendModel =
    Room.Collection


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = UnknownRoom
    | EntryGranted Room.RoomData Mobber


type alias EntryRequest =
    { room : Room, mobber : Mobber }
