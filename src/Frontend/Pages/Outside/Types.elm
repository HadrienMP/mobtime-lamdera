module Frontend.Pages.Outside.Types exposing (Model, Msg(..))


type alias Model =
    { room : String
    , nickname: String
    , mobberId: String
    }


type Msg
    = EnterClicked
    | RoomNameChanged String
    | NicknameChanged String
    | GotMobberId String
