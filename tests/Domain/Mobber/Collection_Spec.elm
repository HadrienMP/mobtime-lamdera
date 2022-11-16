module Domain.Mobber.Collection_Spec exposing (..)

import Domain.Mobber.Collection as Mobbers
import Domain.Mobber.Id exposing (MobberId(..))
import Expect
import Test exposing (Test, describe, test)


suite : Test
suite =
    let
        id =
            MobberId "id"

        mobber =
            { id = id, name = "name" }
    in
    describe "Mobber"
        [ describe "add"
            [ test "succeeds for a new mobber" <|
                \_ ->
                    Mobbers.empty
                        |> Mobbers.add mobber
                        |> Mobbers.get id
                        |> Expect.equal (Just mobber)
            , test "fails when the mobber is already there" <|
                \_ ->
                    let
                        mobber2 =
                            { mobber | name = "with a new fancy name" }
                    in
                    Mobbers.empty
                        |> Mobbers.add mobber
                        |> Mobbers.add mobber2
                        |> Mobbers.get id
                        |> Expect.equal (Just mobber)
            ]
        ]
