module Frontend.Shared exposing (Shared, init, update, Msg(..))

import Browser.Navigation exposing (Key)
import Domain.Mobber.Type exposing (Mobber)



-- Init


type alias Shared =
    { key : Key
    , me : Maybe Mobber
    }


init : Key -> ( Shared, Cmd msg )
init key =
    ( { key = key, me = Nothing }, Cmd.none )



-- Update


type Msg
    = SetMobber Mobber


update : Msg -> Shared -> ( Shared, Cmd Msg )
update msg model =
    case msg of
        SetMobber mobber ->
            ( { model | me = Just mobber }, Cmd.none )
