module Frontend.Pages.Outside.Outside exposing (init, update, view)

import Domain.Mobber.Id
import Domain.Room.Id
import Element
import Element.Background as Background
import Element.Border as Border
import Element.Input as Input
import Frontend.Effect exposing (Effect)
import Frontend.Pages.Outside.Types exposing (Model, Msg(..))
import Frontend.Routes
import Frontend.Shared exposing (Shared)
import Frontend.UI.Button
import Frontend.UI.Input
import Frontend.UI.Space
import Frontend.UI.Theme
import Frontend.UI.Typography
import Frontend.View exposing (View)
import Random
import UUID



init : ( Model, Effect Msg )
init =
    ( { room = ""
      , nickname = ""
      , mobberId = ""
      }
    , UUID.generator
        |> Random.map UUID.toString
        |> Random.generate GotMobberId
        |> Frontend.Effect.fromCmd
    )


update : Shared -> Msg -> Model -> ( Model, Effect Msg )
update shared msg model =
    case msg of
        EnterClicked ->
            ( model
            , Frontend.Effect.batch
                [ model
                    |> toMobber
                    |> Frontend.Shared.SetMobber
                    |> Frontend.Effect.fromShared
                , Domain.Room.Id.fromString model.room
                    |> Frontend.Routes.Inside
                    |> Frontend.Routes.push shared.key
                    |> Frontend.Effect.fromCmd
                ]
            )

        RoomNameChanged updated ->
            ( { model | room = updated }, Frontend.Effect.none )

        NicknameChanged updated ->
            ( { model | nickname = updated }, Frontend.Effect.none )

        GotMobberId id ->
            ( { model | mobberId = id }, Frontend.Effect.none )


toMobber : Model -> { id : Domain.Mobber.Id.MobberId, name : String }
toMobber model =
    { id = Domain.Mobber.Id.MobberId model.mobberId
    , name = model.nickname
    }


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
                , Frontend.UI.Input.text
                    { label = "Nickname"
                    , text = model.nickname
                    , onChange = NicknameChanged
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
