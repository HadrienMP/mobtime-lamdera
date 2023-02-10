module Frontend.UI.Typography exposing (h1, h2, h3)

import Element
import Element.Border as Border
import Element.Font
import Element.Region
import Frontend.UI.Font
import Frontend.UI.Sides
import Frontend.UI.Theme


h1 : List (Element.Attribute msg) -> String -> Element.Element msg
h1 attributes =
    Element.el
        ([ Element.Region.heading 1
         , Element.Font.size Frontend.UI.Font.xxl
         , Element.Font.bold
         ]
            ++ attributes
        )
        << Element.text


h2 : List (Element.Attribute msg) -> String -> Element.Element msg
h2 attributes =
    Element.el
        ([ Element.Region.heading 2
         , Element.Font.size Frontend.UI.Font.xl
         , Element.Font.color Frontend.UI.Theme.primary
         , Frontend.UI.Sides.bottom 1 |> Border.widthEach
         , Element.width Element.fill
         ]
            ++ attributes
        )
        << Element.text


h3 : List (Element.Attribute msg) -> String -> Element.Element msg
h3 attributes =
    Element.el
        ([ Element.Region.heading 3
         , Element.Font.size Frontend.UI.Font.l
         , Element.Font.color Frontend.UI.Theme.primary
         , Frontend.UI.Sides.bottom 1 |> Border.widthEach
         , Element.width Element.fill
         ]
            ++ attributes
        )
        << Element.text
