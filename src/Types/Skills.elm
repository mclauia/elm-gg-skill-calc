module Types.Skills exposing (..)


type UpgradePath
    = Left
    | Right


type UpgradePair
    = UpgradePair Skill Skill


type alias SkillSet =
    { lmb : Skill
    , rmb : Skill
    , q : Skill
    , e : Skill
    , f : Skill
    }


type alias Skill =
    { name : String
    , description : String
    , upgrades : Maybe UpgradePair
    }
