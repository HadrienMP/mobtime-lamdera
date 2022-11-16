module Lib.LamderaExtra exposing (FrontendApp, BackendApp)

import Browser
import Lamdera
import Url


type alias FrontendApp model msg toFrontendMsg =
    { init :
        Lamdera.Url
        -> Lamdera.Key
        -> ( model, Cmd msg )
    , view : model -> Browser.Document msg
    , update : msg -> model -> ( model, Cmd msg )
    , updateFromBackend : toFrontendMsg -> model -> ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , onUrlRequest : Lamdera.UrlRequest -> msg
    , onUrlChange : Url.Url -> msg
    }


type alias BackendApp model msg toBackendMsg =
    { init : ( model, Cmd msg )
    , update : msg -> model -> ( model, Cmd msg )
    , updateFromFrontend : Lamdera.SessionId -> Lamdera.ClientId -> toBackendMsg -> model -> ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    }
