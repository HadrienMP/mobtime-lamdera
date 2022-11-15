module Front.Pages.Inside.Inside exposing (init, update, view)

import Front.Pages.Inside.Types exposing (Model, Msg)
import Front.UI.Typography
import Front.View exposing (View)


init : Model -> ( Model, Cmd Msg )
init model =
    ( model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model, Cmd.none )


view : Model -> View Msg
view model =
    { title = Just <| model.room.name
    , body =
        Front.UI.Typography.h2 model.room.name
    }
