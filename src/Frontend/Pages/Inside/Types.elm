module Frontend.Pages.Inside.Types exposing (Model, Msg, Super(..))

import Domain.Mobber.Collection as Mobbers
import Domain.Mobber.Type as Mobber
import Domain.Room.Id exposing (RoomId)
import Domain.Room.Type exposing (Room)


type alias Model =
    { room : Room
    , mobbers : Mobbers.Collection
    , me : Mobber.Mobber
    }


type Super
    = Setup
        { roomId : RoomId
        , nickname : String
        , ready: Maybe Model
        }
    | Ready Model


type alias Msg =
    ()
