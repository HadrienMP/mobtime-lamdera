module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Lib.AutoDict exposing (AutoDict)
import Model exposing (Mobber, RoomData)
import Url exposing (Url)
import Front.Types



-- Frontend


type alias FrontendModel =
    { key : Key
    , sub : Front.Types.Model
    }


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | NoOpFrontendMsg
    | FrontMsg Front.Types.Msg


type ToBackend
    = Enter EntryRequest



-- Backend


type alias BackendModel =
    AutoDict String RoomData


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = UnknownRoom
    | EntryGranted RoomData Mobber


type alias EntryRequest =
    { roomId : String, mobber : Mobber }


type EntryResponse
    = Confirmed RoomData
    | NotFound
