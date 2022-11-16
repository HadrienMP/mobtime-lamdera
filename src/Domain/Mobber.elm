module Domain.Mobber exposing (Mobber)

import Domain.MobberId exposing (MobberId)


type alias Mobber =
    { id : MobberId, name : String }
