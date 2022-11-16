module Types exposing
    ( BackendModel
    , BackendMsg(..)
    , CreateRequest
    , FrontendModel
    , FrontendMsg
    , ToBackend(..)
    , ToFrontend(..)
    )

import Domain.Mobber.Type exposing (Mobber)
import Domain.Room.Collection as Rooms
import Domain.Room.Type as Room exposing (Room)
import Frontend.Types


type alias FrontendModel =
    Frontend.Types.Model


type alias FrontendMsg =
    Frontend.Types.Msg


type ToBackend
    = CreateRoom CreateRequest



-- Backend


type alias BackendModel =
    Rooms.Collection


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = UnknownRoom
    | EntryGranted Room.RoomData Mobber


type alias CreateRequest =
    { room : Room, mobber : Mobber }
