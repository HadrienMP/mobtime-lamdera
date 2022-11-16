module Frontend.Pages.Inside.Inside exposing (init, update, view)

import Frontend.Pages.Inside.Types exposing (Model, Msg)
import Frontend.UI.Typography
import Frontend.View exposing (View)


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
        Frontend.UI.Typography.h2 model.room.name
    }
