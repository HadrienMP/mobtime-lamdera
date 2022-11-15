module Evergreen.V1.Types exposing (..)

import Browser
import Browser.Navigation
import Evergreen.V1.Mobber
import Evergreen.V1.Room
import Url


type alias OutsideModel =
    { room : String
    , mobber : String
    }


type alias Room =
    Evergreen.V1.Room.Room


type alias Mobber =
    Evergreen.V1.Mobber.Mobber


type alias InsideModel =
    { room : Room
    , mobbers : Evergreen.V1.Mobber.Collection
    , me : Mobber
    }


type Page
    = Outside OutsideModel
    | Inside InsideModel


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , message : Maybe String
    , page : Page
    }


type alias BackendModel =
    Evergreen.V1.Room.Collection


type OutsideMsg
    = EnterClicked
    | RoomNameChanged String
    | MobberNameChanged String


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | OutsideMsg OutsideMsg
    | InsideMsg ()


type alias EntryRequest =
    { room : Room
    , mobber : Mobber
    }


type ToBackend
    = CreateRoom EntryRequest


type BackendMsg
    = NoOpBackendMsg


type alias RoomData =
    Evergreen.V1.Room.RoomData


type ToFrontend
    = UnknownRoom
    | EntryGranted RoomData Mobber
