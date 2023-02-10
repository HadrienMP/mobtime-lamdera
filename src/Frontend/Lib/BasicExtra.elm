module Frontend.Lib.BasicExtra exposing (addCommand)


addCommand : Cmd msg -> ( model, Cmd msg ) -> ( model, Cmd msg )
addCommand command =
    Tuple.mapSecond
        (List.singleton
            >> (::) command
            >> Cmd.batch
        )
