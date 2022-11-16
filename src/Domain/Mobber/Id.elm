module Domain.Mobber.Id exposing (MobberId(..), open)


type MobberId
    = MobberId String


open : MobberId -> String
open (MobberId it) =
    it
