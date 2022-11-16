module Frontend.View exposing (View, map)

import Html.Styled as Html


type alias View msg =
    { title : Maybe String
    , body : Html.Html msg
    }


map : (a -> b) -> View a -> View b
map f view =
    { title = view.title
    , body = Html.map f view.body
    }
