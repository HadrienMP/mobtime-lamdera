module Mobber exposing (Collection(..), Internal, Mobber, add, emptyCollection)

import Dict exposing (Dict)


type alias Mobber =
    { id : String, name : String }


type alias Internal =
    Dict String Mobber


type Collection
    = Internal Internal


open : Collection -> Internal
open mobbers =
    case mobbers of
        Internal internal ->
            internal


emptyCollection : Collection
emptyCollection =
    Dict.empty |> Internal


add : Mobber -> Collection -> Collection
add mobber mobbers =
    open mobbers
        |> Dict.insert mobber.id mobber
        |> Internal
