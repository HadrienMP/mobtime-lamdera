module Domain.Room.RoomId exposing (RoomId(..), open)


type RoomId
    = RoomId String


open : RoomId -> String
open (RoomId it) =
    it
