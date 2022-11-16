module Lib.LamderaExtra exposing (FrontendApp)

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
