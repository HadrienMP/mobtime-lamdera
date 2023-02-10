module Frontend.UI.Sides exposing (Sides, empty, left, right, bottom, top, withLeft, withTop, withBottom, withRight, all)


type alias Sides =
    { top : Int, bottom : Int, left : Int, right : Int }


all : Int -> Sides
all size =
    { top = size, bottom = size, left = size, right = size }


empty : Sides
empty =
    all 0


left : Int -> Sides
left width =
    empty |> withLeft width

right : Int -> Sides
right width =
    empty |> withRight width

bottom : Int -> Sides
bottom width =
    empty |> withBottom width

top : Int -> Sides
top width =
    empty |> withTop width


withLeft : Int -> Sides -> Sides
withLeft width sides =
    { sides | left = width }


withTop : Int -> Sides -> Sides
withTop width sides =
    { sides | top = width }


withBottom : Int -> Sides -> Sides
withBottom width sides =
    { sides | bottom = width }


withRight : Int -> Sides -> Sides
withRight width sides =
    { sides | right = width }
