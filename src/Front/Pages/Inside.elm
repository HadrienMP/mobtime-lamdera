module Front.Pages.Inside exposing (..)

import Front.UI.Typography
import Front.View exposing (View)
import Types


type alias Model =
    Types.InsideModel


init : Model -> ( Model, Cmd Msg )
init model =
    ( model, Cmd.none )


type alias Msg =
    Types.InsideMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> View Msg
view model =
    { title = Just <| model.room.name
    , body =
        Front.UI.Typography.h2 model.room.name
    }
