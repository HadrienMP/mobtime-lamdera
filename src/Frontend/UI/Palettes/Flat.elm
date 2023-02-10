module Frontend.UI.Palettes.Flat exposing (darkBlue, red, white, lightBlue, blue)

import Color exposing (Color)
import Color.Convert exposing (hexToColor)


darkBlue : Color
darkBlue =
    hex "#2C3E50"

red : Color
red = hex "#E74C3C"

white : Color
white = hex "#ECF0F1"

lightBlue : Color
lightBlue = hex "#3498DB"

blue : Color
blue = hex "#2980B9"

-- Utils


hex : String -> Color
hex =
    hexToColor >> Result.withDefault Color.lightPurple
