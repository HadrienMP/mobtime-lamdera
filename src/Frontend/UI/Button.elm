module Frontend.UI.Button exposing (primaryStyle)

import Element
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Frontend.UI.Space
import Frontend.UI.Theme


primaryStyle : List (Element.Attribute msg)
primaryStyle =
    [ Border.rounded 4
    , Border.width 0
    , Background.color Frontend.UI.Theme.buttonPrimaryBackground
    , Font.color Frontend.UI.Theme.buttonPrimaryForeground
    , Element.paddingXY Frontend.UI.Space.m Frontend.UI.Space.s
    , Font.center
    ]
