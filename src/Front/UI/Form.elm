module Front.UI.Form exposing (form, text)

import Css
import Front.UI.Button as Button
import Html.Styled as Html
import Html.Styled.Attributes as Attr
import Html.Styled.Events as Events


form : { onSubmit : Maybe msg, cancel : Maybe (Button.Button msg), submit : Maybe String } -> List (Html.Html msg) -> Html.Html msg
form description children =
    Html.form
        (description.onSubmit
            |> Maybe.map Events.onSubmit
            |> Maybe.map List.singleton
            |> Maybe.withDefault []
        )
        (children
            ++ (case description.submit of
                    Just label ->
                        [ Button.button <| Button.Text { onClick = description.onSubmit, label = label } ]

                    Nothing ->
                        []
               )
            ++ (description.cancel
                    |> Maybe.map Button.button
                    |> Maybe.map List.singleton
                    |> Maybe.withDefault []
               )
        )


text : { onInput : String -> msg, name : String, label : String, value : String } -> Html.Html msg
text field =
    Html.div [ Attr.class "form-field", Attr.css [ Css.padding (Css.px 10) ] ]
        [ Html.label [ Attr.for field.name ] [ Html.text field.label ]
        , Html.input
            [ Attr.id field.name
            , Attr.type_ "text"
            , Attr.value field.value
            , Events.onInput field.onInput
            ]
            []
        ]
