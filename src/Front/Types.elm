module Front.Types exposing (Model, Msg(..), Page(..))

import Front.Pages.Inside.Types
import Front.Pages.Outside.Types
import Lamdera exposing (Key, Url, UrlRequest)


type Page
    = Outside Front.Pages.Outside.Types.Model
    | Inside Front.Pages.Inside.Types.Model


type alias Model =
    { key : Key
    , message : Maybe String
    , page : Page
    }


type Msg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | OutsideMsg Front.Pages.Outside.Types.Msg
    | InsideMsg Front.Pages.Inside.Types.Msg
