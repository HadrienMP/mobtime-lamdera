module Lib.AutoDict exposing (AutoDict, empty, findBy, get, insert, replace)

import Dict exposing (Dict)


type alias InternalModel comparable a =
    { dict : Dict comparable a
    , keyFunction : a -> comparable
    }


type AutoDict comparable a
    = Internal (InternalModel comparable a)


open : AutoDict comparable a -> InternalModel comparable a
open it =
    case it of
        Internal internal ->
            internal


keyFunction : AutoDict comparable a -> a -> comparable
keyFunction =
    open >> .keyFunction


getDict : AutoDict comparable a -> Dict comparable a
getDict =
    open >> .dict


empty : (a -> comparable) -> AutoDict comparable a
empty f =
    Internal { dict = Dict.empty, keyFunction = f }


insert : a -> AutoDict comparable a -> AutoDict comparable a
insert value set =
    let
        internal =
            open set
    in
    Internal { internal | dict = Dict.insert (keyFunction set value) value (getDict set) }


get : comparable -> AutoDict comparable a -> Maybe a
get key set =
    getDict set |> Dict.get key


findBy : (a -> b) -> b -> AutoDict comparable a -> Maybe a
findBy f field autoDict =
    getDict autoDict
        |> Dict.foldl
            (\_ v acc ->
                if f v == field then
                    Just v

                else
                    acc
            )
            Nothing


replace : comparable -> b -> AutoDict comparable b -> AutoDict comparable b
replace id value autoDict =
    updateDict (Dict.update id (always <| Just value)) autoDict


updateDict : (Dict comparable a -> Dict comparable a) -> AutoDict comparable a -> AutoDict comparable a
updateDict f autoDict =
    let
        internal =
            open autoDict
    in
    Internal { internal | dict = f internal.dict }
