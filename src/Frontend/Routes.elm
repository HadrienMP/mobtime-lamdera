module Frontend.Routes exposing (Route(..))

import Domain.RoomId exposing (RoomId)


type Route
    = Inside RoomId
    | Outside
