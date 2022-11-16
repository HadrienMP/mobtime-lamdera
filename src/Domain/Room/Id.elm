module Domain.Room.Id exposing (RoomId(..), open)


type RoomId
    = RoomId String


open : RoomId -> String
open (RoomId it) =
    it
