module Frontend.Pages.Outside.Types exposing (Model, Msg(..))


type alias Model =
    { room : String
    , mobber : String
    }


type Msg
    = EnterClicked
    | RoomNameChanged String
    | MobberNameChanged String
