module Front.Pages.Outside exposing (..)

import Front.UI.Form
import Front.View exposing (View)


type alias Model =
    { room : String
    , mobber : String
    }


init : ( Model, Cmd Msg )
init =
    ( { room = "", mobber = "" }, Cmd.none )


type Msg
    = Enter
    | Room String
    | Mobber String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Enter ->
            ( model, Cmd.none )

        Room updated ->
            ( { model | room = updated }, Cmd.none )

        Mobber updated ->
            ( { model | mobber = updated }, Cmd.none )


view : Model -> View Msg
view model =
    { title = Just "Welcome"
    , body =
        Front.UI.Form.form { onSubmit = Just Enter, cancel = Nothing, submit = Just "Enter" }
            [ Front.UI.Form.text
                { onInput = Room
                , label = "Room"
                , name = "room"
                , value = model.room
                }
            , Front.UI.Form.text
                { onInput = Mobber
                , label = "Nickname"
                , name = "mobber"
                , value = model.mobber
                }
            ]
    }
