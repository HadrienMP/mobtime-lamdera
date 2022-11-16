module Domain.RoomId exposing (RoomId(..), open)


type RoomId
    = RoomId String


open : RoomId -> String
open (RoomId it) =
    it
