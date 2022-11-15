module Front.UI.Typography exposing (..)

import Html.Styled as Html


h1 : String -> Html.Html msg
h1 text =
    Html.h1 [] [ Html.text text ]


h2 : String -> Html.Html msg
h2 text =
    Html.h1 [] [ Html.text text ]
