module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Front.Main
import Html.Events
import Html.Styled as Html
import Lamdera
import Types exposing (..)
import Url


type alias Model =
    FrontendModel


app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = \m -> Sub.none
        , view = view
        }


init : Url.Url -> Nav.Key -> ( Model, Cmd FrontendMsg )
init url key =
    let
        ( front, command ) =
            Front.Main.init
    in
    ( { key = key
      , sub = front
      }
    , Cmd.map FrontMsg command
    )


update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
update msg model =
    case msg of
        UrlClicked urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                External url ->
                    ( model
                    , Nav.load url
                    )

        UrlChanged url ->
            ( model, Cmd.none )

        NoOpFrontendMsg ->
            ( model, Cmd.none )

        FrontMsg subMsg ->
            Front.Main.update subMsg model.sub
                |> Tuple.mapBoth
                    (\updated -> { model | sub = updated })
                    (Cmd.map FrontMsg)


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )


view : Model -> Browser.Document FrontendMsg
view model =
    let
        { title, body } =
            Front.Main.view model.sub
    in
    { title = (title |> Maybe.map (\it -> it ++ " | ") |> Maybe.withDefault " ") ++ "Mob Time"
    , body = body |> Html.map FrontMsg |> Html.toUnstyled |> List.singleton
    }
