module Frontend exposing (Model, app)

import Browser exposing (UrlRequest)
import Browser.Navigation as Nav
import Front.Front
import Front.Types exposing (Msg(..))
import Lamdera
import Types exposing (FrontendModel, FrontendMsg, ToFrontend)
import Url


type alias Model =
    FrontendModel


app :
    { init :
        Lamdera.Url
        -> Lamdera.Key
        -> ( Model, Cmd FrontendMsg )
    , view : Model -> Browser.Document FrontendMsg
    , update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
    , updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
    , subscriptions : Model -> Sub FrontendMsg
    , onUrlRequest : UrlRequest -> FrontendMsg
    , onUrlChange : Url.Url -> FrontendMsg
    }
app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = \_ -> Sub.none
        , view = view
        }


init : Url.Url -> Nav.Key -> ( Model, Cmd FrontendMsg )
init url key =
    Front.Front.init url key


update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
update msg model =
    Front.Front.update msg model


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    Front.Front.updateFromBackend msg model


view : Model -> Browser.Document FrontendMsg
view model =
    Front.Front.view model
