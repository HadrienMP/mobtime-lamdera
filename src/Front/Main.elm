module Front.Main exposing (init, update, updateFromBackend, view)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Front.Pages.Inside.Inside
import Front.Pages.Outside.Outside
import Front.Types exposing (Model, Msg(..), Page(..))
import Front.View
import Html.Styled as Html
import Types exposing (ToFrontend(..))
import Url


init : Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ key =
    let
        ( outside, command ) =
            Front.Pages.Outside.Outside.init
    in
    ( { key = key
      , page = Outside outside
      , message = Nothing
      }
    , Cmd.map OutsideMsg command
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.page ) of
        ( UrlClicked urlRequest, _ ) ->
            case urlRequest of
                Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                External url ->
                    ( model
                    , Nav.load url
                    )

        ( UrlChanged _, _ ) ->
            ( model, Cmd.none )

        ( OutsideMsg subMsg, Outside subModel ) ->
            Front.Pages.Outside.Outside.update subMsg subModel
                |> Tuple.mapBoth Outside (Cmd.map OutsideMsg)
                |> withPage model

        ( InsideMsg subMsg, Inside subModel ) ->
            Front.Pages.Inside.Inside.update subMsg subModel
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
            Front.Pages.Inside.Inside.init { room = roomData.room, mobbers = roomData.mobbers, me = mobber }
                |> Tuple.mapBoth Inside (Cmd.map InsideMsg)
                |> withPage model

        _ ->
            ( model, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    let
        { title, body } =
            case model.page of
                Outside outside ->
                    Front.Pages.Outside.Outside.view outside |> Front.View.map OutsideMsg

                Inside inside ->
                    Front.Pages.Inside.Inside.view inside |> Front.View.map InsideMsg
    in
    { title = (title |> Maybe.map (\it -> it ++ " | ") |> Maybe.withDefault " ") ++ "Mob Time"
    , body =
        Html.div []
            [ body
            , model.message
                |> Maybe.withDefault ""
                |> Html.text
            ]
            |> Html.toUnstyled
            |> List.singleton
    }
