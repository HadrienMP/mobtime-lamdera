module Front.Pages.Inside exposing (..)

import Front.View exposing (View)
import Lib.AutoDict exposing (AutoDict)
import Model exposing (Mobber, Room)
import Front.UI.Typography


type alias Model =
    { room : Room
    , mobbers : AutoDict String Mobber
    , me : Mobber
    }


init : Model -> ( Model, Cmd Msg )
init model =
    ( model, Cmd.none )


type Msg
    = Noop


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Noop ->
            ( model, Cmd.none )


view : Model -> View Msg
view model =
    { title = Just <| model.room.name
    , body =
        Front.UI.Typography.h2 model.room.name
    }
