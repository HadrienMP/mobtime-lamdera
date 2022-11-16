module Frontend.Routes exposing (Route(..))

import Domain.Room.Id exposing (RoomId)


type Route
    = Inside RoomId
    | Outside
