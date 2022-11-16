module Frontend.Pages.Outside.Outside exposing (init, update, view)

import Frontend.Pages.Outside.Types exposing (Model, Msg(..))
import Frontend.UI.Form
import Frontend.View exposing (View)
import Lamdera exposing (sendToBackend)
import Types exposing (ToBackend(..))
import Domain.RoomId exposing (RoomId(..))
import Domain.MobberId exposing (MobberId(..))


init : ( Model, Cmd Msg )
init =
    ( { room = "", mobber = "" }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EnterClicked ->
            ( model
            , sendToBackend <|
                CreateRoom
                    { room = { id = RoomId "myRoom", name = model.room }
                    , mobber = { id = MobberId "toto", name = model.mobber }
                    }
            )

        RoomNameChanged updated ->
            ( { model | room = updated }, Cmd.none )

        MobberNameChanged updated ->
            ( { model | mobber = updated }, Cmd.none )


view : Model -> View Msg
view model =
    { title = Just "Welcome"
    , body =
        Frontend.UI.Form.form { onSubmit = Just EnterClicked, cancel = Nothing, submit = Just "Enter" }
            [ Frontend.UI.Form.text
                { onInput = RoomNameChanged
                , label = "Room"
                , name = "room"
                , value = model.room
                }
            , Frontend.UI.Form.text
                { onInput = MobberNameChanged
                , label = "Nickname"
                , name = "mobber"
                , value = model.mobber
                }
            ]
    }
