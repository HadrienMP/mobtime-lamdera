module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Front.Pages.Inside
import Front.Pages.Outside
import Front.View
import Html.Styled as Html
import Lamdera
import Types exposing (..)
import Url


type alias Model =
    FrontendModel


type alias Msg =
    Types.FrontendMsg


app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = \_ -> Sub.none
        , view = view
        }


init : Url.Url -> Nav.Key -> ( Model, Cmd FrontendMsg )
init _ key =
    let
        ( outside, command ) =
            Front.Pages.Outside.init
    in
    ( { key = key
      , page = Outside outside
      , message = Nothing
      }
    , Cmd.map OutsideMsg command
    )


update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
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


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
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


view : Model -> Browser.Document FrontendMsg
view model =
    let
        { title, body } =
            case model.page of
                Outside outside ->
                    Front.Pages.Outside.view outside |> Front.View.map OutsideMsg

                Inside inside ->
                    Front.Pages.Inside.view inside |> Front.View.map InsideMsg
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
