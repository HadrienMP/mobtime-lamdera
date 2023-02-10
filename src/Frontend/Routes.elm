module Frontend.Routes exposing (Route(..), push, parse, toUrl)

import Browser.Navigation exposing (Key)
import Domain.Room.Id exposing (RoomId)
import Url exposing (Url)
import Url.Builder
import Url.Parser exposing ((</>))


type Route
    = Inside RoomId
    | Outside

parse : Url -> Route
parse url =
    Url.Parser.parse parser url
        |> Maybe.withDefault Outside


parser : Url.Parser.Parser (Route -> a) a
parser =
    Url.Parser.oneOf
        [ Url.Parser.map Outside Url.Parser.top
        , Url.Parser.map (Domain.Room.Id.fromString >> Inside) (Url.Parser.s "room" </> Url.Parser.string)
        ]


toUrl : Route -> String
toUrl route =
    case route of
        Outside ->
            Url.Builder.absolute [] []

        Inside roomId ->
            Url.Builder.absolute [ "room", roomId |> Domain.Room.Id.asString ] []


push : Key -> Route -> Cmd msg
push key route =
    Browser.Navigation.pushUrl key <| toUrl route
