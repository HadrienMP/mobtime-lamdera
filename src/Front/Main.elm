module Front.Main exposing (..)

import Front.Outside
import Front.View exposing (View)


type Model
    = Outside Front.Outside.Model


init : ( Model, Cmd Msg )
init =
    Front.Outside.init |> Tuple.mapBoth Outside (Cmd.map OutsideMsg)


type Msg
    = OutsideMsg Front.Outside.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( OutsideMsg subMsg, Outside subModel ) ->
            Front.Outside.update subMsg subModel |> Tuple.mapBoth Outside (Cmd.map OutsideMsg)


view : Model -> View Msg
view model =
    case model of
        Outside outside ->
            Front.Outside.view outside |> Front.View.map OutsideMsg
