module Backend exposing (..)

import Lamdera exposing (ClientId, SessionId, sendToFrontend)
import Lib.AutoDict as AutoDict
import Types exposing (..)


type alias Model =
    BackendModel


app :
    { init : ( Model, Cmd BackendMsg )
    , update : BackendMsg -> Model -> ( Model, Cmd BackendMsg )
    , updateFromFrontend : SessionId -> ClientId -> ToBackend -> Model -> ( Model, Cmd BackendMsg )
    , subscriptions : Model -> Sub BackendMsg
    }
app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = \_ -> Sub.none
        }


init : ( Model, Cmd BackendMsg )
init =
    ( AutoDict.empty (.room >> .id)
    , Cmd.none
    )


update : BackendMsg -> Model -> ( Model, Cmd BackendMsg )
update msg model =
    case msg of
        NoOpBackendMsg ->
            ( model, Cmd.none )


updateFromFrontend : SessionId -> ClientId -> ToBackend -> Model -> ( Model, Cmd BackendMsg )
updateFromFrontend _ clientId msg model =
    case msg of
        Enter request ->
            case AutoDict.get request.roomId model of
                Nothing ->
                    ( model
                    , sendToFrontend clientId UnknownRoom
                    )

                Just roomData ->
                    ( AutoDict.replace
                        request.roomId
                        { roomData | mobbers = AutoDict.insert request.mobber roomData.mobbers }
                        model
                    , sendToFrontend clientId (EntryGranted roomData request.mobber)
                    )
