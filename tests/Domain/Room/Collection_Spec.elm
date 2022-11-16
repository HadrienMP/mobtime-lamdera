module Domain.Room.Collection_Spec exposing (..)

import Domain.Mobber.Collection as Mobbers
import Domain.Room.Collection as Rooms
import Domain.Room.Id exposing (RoomId(..))
import Expect
import Test exposing (Test, describe, test)


suite : Test
suite =
    let
        roomId =
            RoomId "room id"

        room =
            { name = "my room", id = roomId }

        roomData =
            { room = room, mobbers = Mobbers.empty }
    in
    describe "Rooms"
        [ describe "add"
            [ test "adds new room" <|
                \_ ->
                    Rooms.empty
                        |> Rooms.add roomData
                        |> Rooms.get roomId
                        |> Expect.equal (Just roomData)
            , test "does nothing when the room is already there" <|
                \_ ->
                    let
                        room2 =
                            { roomData | room = { room | name = "with a new fancy name" } }
                    in
                    Rooms.empty
                        |> Rooms.add roomData
                        |> Rooms.add room2
                        |> Rooms.get roomId
                        |> Expect.equal (Just roomData)
            ]
        ]
