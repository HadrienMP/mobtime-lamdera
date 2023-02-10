module Frontend.Main exposing (init, update, updateFromBackend, view)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Element
import Element.Background as Background
import Element.Font as Font
import Element.Region
import Frontend.Effect
import Frontend.Pages.Inside.Inside
import Frontend.Pages.Outside.Outside
import Frontend.Routes
import Frontend.Shared
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
        ( shared, sharedCommand ) =
            Frontend.Shared.init key

        ( page, pageEffect ) =
            initPage shared url

        ( nextShared, pageCmd ) =
            applyEffect shared pageEffect

        model =
            { shared = nextShared
            , page = page
            , message = Nothing
            }
    in
    ( model
    , Cmd.batch [ pageCmd, sharedCommand ]
    )


initPage : Frontend.Shared.Shared -> Url.Url -> ( Page, Frontend.Effect.Effect Msg )
initPage shared url =
    case Frontend.Routes.parse url of
        Frontend.Routes.Outside ->
            Frontend.Pages.Outside.Outside.init
                |> Tuple.mapBoth Outside (Frontend.Effect.map OutsideMsg)

        Frontend.Routes.Inside roomId ->
            Frontend.Pages.Inside.Inside.init shared roomId
                |> Tuple.mapBoth Inside (Frontend.Effect.map InsideMsg)


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
            initPage model.shared url |> toModelCmd model

        ( OutsideMsg subMsg, Outside subModel ) ->
            Frontend.Pages.Outside.Outside.update model.shared subMsg subModel
                |> Tuple.mapBoth Outside (Frontend.Effect.map OutsideMsg)
                |> toModelCmd model

        ( InsideMsg subMsg, Inside subModel ) ->
            Frontend.Pages.Inside.Inside.update subMsg subModel
                |> Tuple.mapBoth Inside (Frontend.Effect.map InsideMsg)
                |> toModelCmd model

        _ ->
            ( model, Cmd.none )


toModelCmd : Model -> ( Page, Frontend.Effect.Effect Msg ) -> ( Model, Cmd Msg )
toModelCmd model ( page, effect ) =
    let
        ( nextShared, command ) =
            applyEffect model.shared effect
    in
    ( { model
        | page = page
        , shared = nextShared
      }
    , command
    )


applyEffect : Frontend.Shared.Shared -> Frontend.Effect.Effect Msg -> ( Frontend.Shared.Shared, Cmd Msg )
applyEffect shared effect =
    Frontend.Effect.apply shared SharedMsg effect


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
