module Domain.Mobber.Type exposing (Mobber)

import Domain.Mobber.Id exposing (MobberId)


type alias Mobber =
    { id : MobberId, name : String }
