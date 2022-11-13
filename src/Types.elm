module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Front.Main
import Url exposing (Url)


type alias FrontendModel =
    { key : Key
    , sub : Front.Main.Model
    }


type alias BackendModel =
    { message : String
    }


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | NoOpFrontendMsg
    | FrontMsg Front.Main.Msg


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend
