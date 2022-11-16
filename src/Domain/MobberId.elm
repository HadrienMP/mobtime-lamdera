module Domain.MobberId exposing (..)


type MobberId
    = MobberId String


open : MobberId -> String
open (MobberId it) =
    it
