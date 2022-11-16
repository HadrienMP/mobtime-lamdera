module Frontend.Pages.Inside.Types exposing (Model, Msg)

import Domain.Mobber.Type as Mobber
import Domain.Mobber.Collection as Mobbers
import Domain.Room exposing (Room)


type alias Model =
    { room : Room
    , mobbers : Mobbers.Collection
    , me : Mobber.Mobber
    }


type alias Msg =
    ()
