module Frontend.Pages.Outside.Outside exposing (init, update, view)

import Element
import Element.Background as Background
import Element.Border as Border
import Element.Input as Input
import Frontend.Pages.Outside.Types exposing (Model, Msg(..))
import Frontend.Routes
import Frontend.Shared exposing (Shared)
import Frontend.UI.Button
import Frontend.UI.Input
import Frontend.UI.Space
import Frontend.UI.Theme
import Frontend.UI.Typography
import Frontend.View exposing (View)
import Domain.Room.Id


init : ( Model, Cmd Msg )
init =
    ( { room = "" }, Cmd.none )


update : Shared -> Msg -> Model -> ( Model, Cmd Msg )
update shared msg model =
    case msg of
        EnterClicked ->
            ( model
            , Frontend.Routes.push shared.key <| Frontend.Routes.Inside <| Domain.Room.Id.fromString model.room
            )

        RoomNameChanged updated ->
            ( { model | room = updated }, Cmd.none )


view : Model -> View Msg
view model =
    { title = Nothing
    , body =
        Element.column
            [ Element.spacing Frontend.UI.Space.l
            , Element.centerX
            , Element.centerY
            , Border.color Frontend.UI.Theme.border
            , Border.width 1
            , Border.rounded 5
            , Background.color Frontend.UI.Theme.surface
            , Element.padding Frontend.UI.Space.l
            ]
            [ Frontend.UI.Typography.h1 [ Element.centerX ]
                "Login"
            , Element.column [ Element.width Element.fill ]
                [ Frontend.UI.Input.text
                    { label = "Room"
                    , text = model.room
                    , onChange = RoomNameChanged
                    }
                ]
            , Input.button
                (Frontend.UI.Button.primaryStyle
                    ++ [ Element.width Element.fill
                       ]
                )
                { onPress = Just EnterClicked
                , label = Element.text "Enter"
                }
            ]
    }
