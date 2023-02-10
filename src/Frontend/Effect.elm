module Frontend.Effect exposing (Effect, apply, batch, fromCmd, fromShared, map, none)

import Frontend.Shared


type Effect msg
    = Atomic (Atomic msg)
    | Batch (List (Atomic msg))


type Atomic msg
    = SharedMsg Frontend.Shared.Msg
    | Command (Cmd msg)


fromShared : Frontend.Shared.Msg -> Effect msg
fromShared =
    Atomic << SharedMsg


fromCmd : Cmd msg -> Effect msg
fromCmd =
    Atomic << Command


none : Effect msg
none =
    Cmd.none |> fromCmd


batch : List (Effect msg) -> Effect msg
batch effects =
    effects
        |> List.map
            (\effect ->
                case effect of
                    Atomic atomic ->
                        [ atomic ]

                    Batch atomics ->
                        atomics
            )
        |> List.foldl (++) []
        |> Batch


map : (a -> b) -> Effect a -> Effect b
map f effect =
    case effect of
        Atomic atomic ->
            mapAtomic f atomic |> Atomic

        Batch effects ->
            effects |> List.map (mapAtomic f) |> Batch


mapAtomic : (a -> b) -> Atomic a -> Atomic b
mapAtomic f effect =
    case effect of
        Command command ->
            Cmd.map f command |> Command

        SharedMsg sharedMsg ->
            SharedMsg sharedMsg


apply :
    Frontend.Shared.Shared
    -> (Frontend.Shared.Msg -> msg)
    -> Effect msg
    -> ( Frontend.Shared.Shared, Cmd msg )
apply shared toMsg effect =
    case effect of
        Atomic atomic ->
            applyAtomic shared toMsg atomic

        Batch effects ->
            applyBatch toMsg effects ( shared, [] )


applyBatch :
    (Frontend.Shared.Msg -> msg)
    -> List (Atomic msg)
    -> ( Frontend.Shared.Shared, List (Cmd msg) )
    -> ( Frontend.Shared.Shared, Cmd msg )
applyBatch toMsg atomics ( shared, commands ) =
    case atomics of
        [] ->
            ( shared, Cmd.batch commands )

        head :: tail ->
            applyBatch toMsg
                tail
                (applyAtomic shared toMsg head
                    |> Tuple.mapSecond (\nextCmd -> nextCmd :: commands)
                )


applyAtomic :
    Frontend.Shared.Shared
    -> (Frontend.Shared.Msg -> msg)
    -> Atomic msg
    -> ( Frontend.Shared.Shared, Cmd msg )
applyAtomic shared toMsg atomic =
    case atomic of
        SharedMsg subMsg ->
            Frontend.Shared.update subMsg shared
                |> Tuple.mapSecond (Cmd.map toMsg)

        Command command ->
            ( shared, command )
