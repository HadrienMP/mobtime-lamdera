module Frontend.Main exposing (init, update, updateFromBackend, view)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Element
import Element.Background as Background
import Element.Font as Font
import Element.Region
import Frontend.Pages.Inside.Inside
import Frontend.Pages.Outside.Outside
import Frontend.Routes
import Frontend.Types exposing (Model, Msg(..), Page(..))
import Frontend.UI.Font
import Frontend.UI.Space
import Frontend.UI.Tape
import Frontend.UI.Theme
import Frontend.UI.Typography
import Frontend.View
import Types exposing (ToFrontend(..))
import Url


init : Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init url key =
    let
        ( page, command ) =
            initPage url
    in
    ( { shared = { key = key }
      , page = page
      , message = Nothing
      }
    , command
    )


initPage : Url.Url -> ( Page, Cmd Msg )
initPage url =
    case Frontend.Routes.parse url of
        Frontend.Routes.Outside ->
            Frontend.Pages.Outside.Outside.init
                |> Tuple.mapBoth Outside (Cmd.map OutsideMsg)

        Frontend.Routes.Inside roomId ->
            Frontend.Pages.Inside.Inside.init roomId
                |> Tuple.mapBoth Inside (Cmd.map InsideMsg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.page ) of
        ( UrlClicked urlRequest, _ ) ->
            case urlRequest of
                Internal url ->
                    ( model
                    , Nav.pushUrl model.shared.key (Url.toString url)
                    )

                External url ->
                    ( model
                    , Nav.load url
                    )

        ( UrlChanged url, _ ) ->
            initPage url |> Tuple.mapFirst (\page -> { model | page = page })

        ( OutsideMsg subMsg, Outside subModel ) ->
            Frontend.Pages.Outside.Outside.update model.shared subMsg subModel
                |> Tuple.mapBoth Outside (Cmd.map OutsideMsg)
                |> withPage model

        ( InsideMsg subMsg, Inside subModel ) ->
            Frontend.Pages.Inside.Inside.update subMsg subModel
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

        ( EntryGranted roomData _, Outside _ ) ->
            ( model, Frontend.Routes.push model.shared.key <| Frontend.Routes.Inside roomData.room.id )

        _ ->
            ( model, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    let
        { title, body } =
            case model.page of
                Outside outside ->
                    Frontend.Pages.Outside.Outside.view outside |> Frontend.View.map OutsideMsg

                Inside inside ->
                    Frontend.Pages.Inside.Inside.view inside |> Frontend.View.map InsideMsg
    in
    { title = (title |> Maybe.map (\it -> it ++ " | ") |> Maybe.withDefault " ") ++ "K7-Time"
    , body =
        [ Element.layoutWith
            { options =
                [ Element.focusStyle
                    { borderColor = Just <| Frontend.UI.Theme.primary
                    , backgroundColor = Nothing
                    , shadow = Nothing
                    }
                ]
            }
            [ Background.color Frontend.UI.Theme.background
            , Font.color Frontend.UI.Theme.onBackground
            , Font.size Frontend.UI.Font.m
            ]
          <|
            Element.column
                [ Element.width Element.fill
                , Element.height Element.fill
                ]
                [ Element.link []
                    { url = Frontend.Routes.toUrl Frontend.Routes.Outside
                    , label =
                        Element.row
                            [ Element.Region.navigation
                            , Element.padding Frontend.UI.Space.s
                            , Element.spacing Frontend.UI.Space.s
                            ]
                            [ Frontend.UI.Tape.display
                                { sizeInPx = 30
                                , color = Frontend.UI.Theme.onBackground
                                }
                                |> Element.html
                                |> Element.el []
                            , Frontend.UI.Typography.h1
                                [ Font.size Frontend.UI.Font.m
                                , Font.light
                                , Element.moveDown 1
                                ]
                                "K7-Time"
                            ]
                    }
                , Element.el
                    [ Element.height Element.fill
                    , Element.width Element.fill
                    ]
                    body
                ]
        ]
    }
