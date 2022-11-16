module Frontend.Types exposing (Model, Msg(..), Page(..))

import Frontend.Pages.Inside.Types
import Frontend.Pages.Outside.Types
import Lamdera exposing (Key, Url, UrlRequest)


type Page
    = Outside Frontend.Pages.Outside.Types.Model
    | Inside Frontend.Pages.Inside.Types.Model


type alias Model =
    { key : Key
    , message : Maybe String
    , page : Page
    }


type Msg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | OutsideMsg Frontend.Pages.Outside.Types.Msg
    | InsideMsg Frontend.Pages.Inside.Types.Msg
