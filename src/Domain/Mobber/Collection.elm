module Domain.Mobber.Collection exposing (Collection(..), Internal, add, empty)

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
add mobber mobbers =
    open mobbers
        |> Dict.insert (MobberId.open mobber.id) mobber
        |> Internal
