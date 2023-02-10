module Domain.Room.Id exposing (RoomId(..), asString, fromString)


type RoomId
    = RoomId String


open : RoomId -> String
open (RoomId it) =
    it

asString : RoomId -> String
asString = open

fromString : String -> RoomId
fromString = RoomId