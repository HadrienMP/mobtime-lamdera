module Frontend.UI.Space exposing (xs, s, m, l, xl)

import Element


scaled : Int -> Int
scaled =
    Element.modular 6 2 >> round


xs : Int
xs =
    scaled 1


s : Int
s =
    scaled 2


m : Int
m =
    scaled 3


l : Int
l =
    scaled 4


xl : Int
xl =
    scaled 5
