module Domain.RoomId exposing (..)


type RoomId
    = RoomId String


open : RoomId -> String
open (RoomId it) =
    it
