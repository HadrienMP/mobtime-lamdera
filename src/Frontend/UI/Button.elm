module Frontend.UI.Button exposing (Button(..), TextButton, button)

import Html.Styled as Html
import Html.Styled.Events as Events


type Button msg
    = Text (TextButton msg)


type alias TextButton msg =
    { onClick : Maybe msg, label : String }


button : Button msg -> Html.Html msg
button description =
    case description of
        Text textButton ->
            text textButton


text : TextButton msg -> Html.Html msg
text description =
    Html.button
        (description.onClick
            |> Maybe.map Events.onClick
            |> Maybe.map List.singleton
            |> Maybe.withDefault []
        )
        [ Html.text description.label ]
