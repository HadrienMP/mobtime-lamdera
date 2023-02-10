module Frontend.UI.Theme exposing (background, border, buttonPrimaryBackground, buttonPrimaryForeground, fromElmUI, onBackground, onPrimary, onSurface, primary, surface, toElmUI, darkText)

import Color
import Color.Manipulate
import Element exposing (Color)
import Frontend.UI.Palettes.Flat


background : Color
background =
    Frontend.UI.Palettes.Flat.darkBlue
        |> Color.Manipulate.darken 0.1
        |> toElmUI


onBackground : Color
onBackground =
    Frontend.UI.Palettes.Flat.white
        |> toElmUI


surface : Color
surface =
    Frontend.UI.Palettes.Flat.darkBlue
        |> toElmUI


onSurface : Color
onSurface =
    Frontend.UI.Palettes.Flat.white
        |> toElmUI


border : Color
border =
    Color.rgba 0 0 0 1 |> toElmUI


buttonPrimaryBackground : Color
buttonPrimaryBackground =
    Frontend.UI.Palettes.Flat.lightBlue
        |> toElmUI


buttonPrimaryForeground : Color
buttonPrimaryForeground =
    Frontend.UI.Palettes.Flat.white
        |> toElmUI


primary : Color
primary =
    Frontend.UI.Palettes.Flat.lightBlue
        |> toElmUI


onPrimary : Color
onPrimary =
    Frontend.UI.Palettes.Flat.white
        |> toElmUI


darkText : Color
darkText =
    Frontend.UI.Palettes.Flat.white
        |> Color.Manipulate.darken 0.3
        |> toElmUI



--
-- Utils
--


fromElmUI : Color -> Color.Color
fromElmUI =
    Element.toRgb >> Color.fromRgba


toElmUI : Color.Color -> Color
toElmUI =
    Color.toRgba >> Element.fromRgb
