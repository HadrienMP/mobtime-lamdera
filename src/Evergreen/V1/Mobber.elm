module Evergreen.V1.Mobber exposing (..)

import Dict


type alias Mobber =
    { id : String
    , name : String
    }


type alias Internal =
    Dict.Dict String Mobber


type Collection
    = Internal Internal
