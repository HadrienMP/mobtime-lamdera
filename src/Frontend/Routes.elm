module Frontend.Routes exposing (Route(..))

import Domain.Room.RoomId exposing (RoomId)


type Route
    = Inside RoomId
    | Outside
