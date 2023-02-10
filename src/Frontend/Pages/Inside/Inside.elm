module Frontend.Pages.Inside.Inside exposing (init, update, view)

import Domain.Room.Id exposing (RoomId)
import Frontend.Pages.Inside.Types exposing (Msg, Super(..))
import Frontend.UI.Typography
import Frontend.View exposing (View)
import Frontend.Effect exposing (Effect)


init : RoomId -> ( Super, Cmd Msg )
init roomId =
    ( Setup { roomId = roomId, nickname = "", ready = Nothing }
    , Cmd.none
    )


update : Msg -> Super -> ( Super, Effect Msg )
update _ model =
    ( model, Frontend.Effect.none )


view : Super -> View Msg
view model =
    { title =
        Just <|
            case model of
                Ready ready ->
                    ready.room.name

                Setup setup ->
                    setup.ready
                        |> Maybe.map (.room >> .name)
                        |> Maybe.withDefault
                            (setup.roomId |> Domain.Room.Id.asString)
    , body =
        Frontend.UI.Typography.h2 [] "Coucou"
    }
