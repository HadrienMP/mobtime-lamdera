module Frontend.UI.Widgets exposing (loader, shadow)

import Element
import Frontend.UI.Palettes.Flat
import Frontend.UI.Theme exposing (toElmUI)
import Loaders
import Color.Manipulate exposing (darken)


loader : Int -> Element.Element msg
loader size =
    Loaders.threeDots (toFloat size) "#000000"
        |> Element.html
        |> Element.el []


shadow : { offset : (number, number), size : number, blur : number, color : Element.Color }
shadow =
    { offset = ( 1, 1 )
    , size = 1
    , blur = 2
    , color = Frontend.UI.Palettes.Flat.blue |> darken 0.05|> toElmUI
    }
