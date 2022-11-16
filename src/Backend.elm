module Backend exposing (Model, app)

import Lamdera exposing (ClientId, SessionId, sendToFrontend)
import Domain.Mobber.Collection as Mobbers
import Domain.Room.Collection as Rooms
import Types exposing (BackendModel, BackendMsg(..), ToBackend(..), ToFrontend(..))


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
    ( Rooms.emptyCollection
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
        CreateRoom request ->
            let
                roomData =
                    { room = request.room
                    , mobbers =
                        Mobbers.empty
                            |> Mobbers.add request.mobber
                    }
            in
            ( Rooms.add roomData model
            , sendToFrontend clientId (EntryGranted roomData request.mobber)
            )
