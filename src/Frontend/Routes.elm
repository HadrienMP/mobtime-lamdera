module Frontend.Routes exposing (..)

import Domain.RoomId exposing (RoomId)


type Route
    = Inside RoomId
    | Outside
