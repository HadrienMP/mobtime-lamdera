module Front.Pages.Inside.Types exposing (Model, Msg)

import Mobber
import Room exposing (Room)


type alias Model =
    { room : Room
    , mobbers : Mobber.Collection
    , me : Mobber.Mobber
    }


type alias Msg =
    ()
