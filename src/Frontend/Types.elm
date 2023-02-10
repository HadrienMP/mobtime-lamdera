module Frontend.Types exposing (Model, Msg(..), Page(..))

import Frontend.Pages.Inside.Types
import Frontend.Pages.Outside.Types
import Lamdera exposing (Url, UrlRequest)
import Frontend.Shared exposing (Shared)


type Page
    = Outside Frontend.Pages.Outside.Types.Model
    | Inside Frontend.Pages.Inside.Types.Super


type alias Model =
    { shared: Shared
    , page: Page
    , message : Maybe String
    }


type Msg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | OutsideMsg Frontend.Pages.Outside.Types.Msg
    | InsideMsg Frontend.Pages.Inside.Types.Msg
    | SharedMsg Frontend.Shared.Msg
