module Front.Main exposing (..)

import Front.Pages.Inside
import Front.Pages.Outside
import Front.Types exposing (..)
import Front.View exposing (View)
import Types exposing (ToFrontend(..))


init : ( Model, Cmd Msg )
init =
    let
        ( outside, command ) =
            Front.Pages.Outside.init
    in
    ( { page = Outside outside, message = Nothing }
    , Cmd.map OutsideMsg command
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.page ) of
        ( OutsideMsg subMsg, Outside subModel ) ->
            Front.Pages.Outside.update subMsg subModel
                |> Tuple.mapBoth Outside (Cmd.map OutsideMsg)
                |> withPage model

        ( InsideMsg subMsg, Inside subModel ) ->
            Front.Pages.Inside.update subMsg subModel
                |> Tuple.mapBoth Inside (Cmd.map InsideMsg)
                |> withPage model

        _ ->
            ( model, Cmd.none )


withPage : Model -> ( Page, Cmd Msg ) -> ( Model, Cmd Msg )
withPage model ( page, command ) =
    ( { model | page = page }, command )


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd Msg )
updateFromBackend msg model =
    case ( msg, model.page ) of
        ( UnknownRoom, _ ) ->
            ( { model | message = Just "Unknown room" }, Cmd.none )

        ( EntryGranted roomData mobber, Outside _ ) ->
            Front.Pages.Inside.init { room = roomData.room, mobbers = roomData.mobbers, me = mobber }
                |> Tuple.mapBoth Inside (Cmd.map InsideMsg)
                |> withPage model

        _ ->
            ( model, Cmd.none )


view : Model -> View Msg
view model =
    case model.page of
        Outside outside ->
            Front.Pages.Outside.view outside |> Front.View.map OutsideMsg

        Inside inside ->
            Front.Pages.Inside.view inside |> Front.View.map InsideMsg
