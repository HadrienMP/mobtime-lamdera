module Front.UI.Typography exposing (h2)

import Html.Styled as Html


h2 : String -> Html.Html msg
h2 text =
    Html.h1 [] [ Html.text text ]
