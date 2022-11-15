module Front.Types exposing (..)
import Front.Pages.Outside
import Front.Pages.Inside


type Page
    = Outside Front.Pages.Outside.Model
    | Inside Front.Pages.Inside.Model


type alias Model =
    { message : Maybe String
    , page : Page
    }


type Msg
    = OutsideMsg Front.Pages.Outside.Msg
    | InsideMsg Front.Pages.Inside.Msg