module Domain.MobberId exposing (MobberId(..), open)


type MobberId
    = MobberId String


open : MobberId -> String
open (MobberId it) =
    it
