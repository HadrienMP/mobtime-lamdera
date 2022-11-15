module Front.Pages.Outside exposing (Model, Msg, init, update, view)

import Front.UI.Form
import Front.View exposing (View)
import Lamdera exposing (sendToBackend)
import Types exposing (OutsideMsg(..), ToBackend(..))


type alias Model =
    Types.OutsideModel


type alias Msg =
    OutsideMsg


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
                    { room = { id = "room", name = model.room }
                    , mobber = { id = "toto", name = model.mobber }
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
        Front.UI.Form.form { onSubmit = Just EnterClicked, cancel = Nothing, submit = Just "Enter" }
            [ Front.UI.Form.text
                { onInput = RoomNameChanged
                , label = "Room"
                , name = "room"
                , value = model.room
                }
            , Front.UI.Form.text
                { onInput = MobberNameChanged
                , label = "Nickname"
                , name = "mobber"
                , value = model.mobber
                }
            ]
    }
