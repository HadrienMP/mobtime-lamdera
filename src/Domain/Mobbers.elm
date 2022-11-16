module Domain.Mobbers exposing (Collection(..), Internal, add, empty)

import Dict exposing (Dict)
import Domain.Mobber exposing (Mobber)
import Domain.MobberId as MobberId


type alias Internal =
    Dict String Mobber


type Collection
    = Internal Internal


open : Collection -> Internal
open mobbers =
    case mobbers of
        Internal internal ->
            internal


empty : Collection
empty =
    Dict.empty |> Internal


add : Mobber -> Collection -> Collection
add mobber mobbers =
    open mobbers
        |> Dict.insert (MobberId.open mobber.id) mobber
        |> Internal
