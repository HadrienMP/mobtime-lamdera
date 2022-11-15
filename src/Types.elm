module Types exposing (BackendModel, BackendMsg(..), EntryRequest, FrontendModel, FrontendMsg(..), InsideModel, InsideMsg, Mobber, OutsideModel, OutsideMsg(..), Page(..), Room, RoomData, ToBackend(..), ToFrontend(..))

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Mobber
import Room
import Url exposing (Url)



-- Model


type alias Room =
    Room.Room


type alias RoomData =
    Room.RoomData


type alias Mobber =
    Mobber.Mobber



-- Frontend


type alias InsideModel =
    { room : Room
    , mobbers : Mobber.Collection
    , me : Mobber
    }


type alias InsideMsg =
    ()


type alias OutsideModel =
    { room : String
    , mobber : String
    }


type OutsideMsg
    = EnterClicked
    | RoomNameChanged String
    | MobberNameChanged String


type Page
    = Outside OutsideModel
    | Inside InsideModel


type alias FrontendModel =
    { key : Key
    , message : Maybe String
    , page : Page
    }


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | OutsideMsg OutsideMsg
    | InsideMsg ()


type ToBackend
    = CreateRoom EntryRequest



-- Backend


type alias BackendModel =
    Room.Collection


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = UnknownRoom
    | EntryGranted RoomData Mobber


type alias EntryRequest =
    { room : Room, mobber : Mobber }