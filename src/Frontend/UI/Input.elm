module Frontend.UI.Input exposing (labelStyle, style, text)

import Color
import Color.Manipulate
import Element
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Frontend.UI.Font
import Frontend.UI.Sides
import Frontend.UI.Space
import Frontend.UI.Theme
import Html.Attributes
import Lib.CoreExtra exposing (divideBy)


text : { text : String, label : String, onChange : String -> msg } -> Element.Element msg
text params =
    Input.text style
        { placeholder = Just <| Input.placeholder [] <| Element.text params.label
        , label =
            Input.labelAbove
                [ Element.moveDown (toFloat Frontend.UI.Font.s / 2 + 4)
                , Font.size Frontend.UI.Font.xs
                , Element.width Element.shrink
                , Element.moveRight <| toFloat 8
                , Element.paddingXY 4 0
                , mimicBackgrounds
                , Element.htmlAttribute <| Html.Attributes.style "z-index" "10"
                ]
            <|
                Element.text params.label
        , onChange = params.onChange
        , text = params.text
        }


mimicBackgrounds : Element.Attr () msg
mimicBackgrounds =
    Element.htmlAttribute <|
        Html.Attributes.style "background" <|
            "linear-gradient(to bottom, "
                ++ (Frontend.UI.Theme.surface
                        |> Frontend.UI.Theme.fromElmUI
                        |> Color.toCssString
                   )
                ++ " 50%, "
                ++ (background |> Frontend.UI.Theme.fromElmUI |> Color.toCssString)
                ++ " 50%, "
                ++ (background |> Frontend.UI.Theme.fromElmUI |> Color.toCssString)
                ++ " 100%)"


style : List (Element.Attribute msg)
style =
    [ Background.color Frontend.UI.Theme.surface
    , Font.color Frontend.UI.Theme.onSurface
    , Border.rounded 5
    , Border.width 1
    , Border.color Frontend.UI.Theme.border
    , Element.padding Frontend.UI.Space.s
    , Element.width Element.fill
    , background
        |> Background.color
    ]


background : Element.Color
background =
    Frontend.UI.Theme.surface
        |> Frontend.UI.Theme.fromElmUI
        |> Color.Manipulate.lighten 0.06
        |> Frontend.UI.Theme.toElmUI


labelStyle : List (Element.Attribute msg)
labelStyle =
    [ Element.alignBottom
    , Element.paddingXY Frontend.UI.Space.s
        (Frontend.UI.Font.m
            + (2 * Frontend.UI.Space.s)
            - Frontend.UI.Font.s
            |> divideBy 2
        )
    , Font.size Frontend.UI.Font.s
    , Border.color Frontend.UI.Theme.onSurface
    , Frontend.UI.Sides.all 1 |> Frontend.UI.Sides.withRight 0 |> Border.widthEach
    , Border.roundEach { topLeft = 5, bottomLeft = 5, topRight = 0, bottomRight = 0 }
    , Border.color Frontend.UI.Theme.border
    , Element.moveRight 5
    , Background.color Frontend.UI.Theme.primary
    , Font.color Frontend.UI.Theme.onPrimary
    ]
