module Domain.Mobber.Collection exposing (Collection(..), Internal, add, empty, get)

import Dict exposing (Dict)
import Domain.Mobber.Id as MobberId
import Domain.Mobber.Type exposing (Mobber)


type alias Internal =
    Dict String Mobber


type Collection
    = Internal Internal


open : Collection -> Internal
open (Internal mobbers) =
    mobbers


empty : Collection
empty =
    Dict.empty |> Internal


add : Mobber -> Collection -> Collection
add value (Internal collection) =
    Internal <|
        if Dict.member (MobberId.open value.id) collection then
            collection

        else
            Dict.insert (MobberId.open value.id) value collection


get : MobberId.MobberId -> Collection -> Maybe Mobber
get id =
    open >> Dict.get (MobberId.open id)
