module Frontend.View exposing (View, map)

import Element


type alias View msg =
    { title : Maybe String
    , body : Element.Element msg
    }


map : (a -> b) -> View a -> View b
map f view =
    { title = view.title
    , body = Element.map f view.body
    }
