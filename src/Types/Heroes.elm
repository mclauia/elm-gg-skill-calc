module Types.Heroes exposing (..)


type alias Hero =
    { name : String
    , skills : SkillSet
    }


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
    , upgrades : Maybe Upgrade
    }


type Upgrade
    = Upgrade Skill Skill


tripp : Hero
tripp =
    Hero "Tripp"
        (SkillSet (Skill "Lightning Strikes 1" "its a strike" (Just (Upgrade (Skill "Lightning Strikes L" "its a strike" Nothing) (Skill "Lightning Strikes R" "its a strike" Nothing))))
            (Skill "Lightning Strikes 2" "its a strike" (Just (Upgrade (Skill "Lightning Strikes L" "its a strike" Nothing) (Skill "Lightning Strikes R" "its a strike" Nothing))))
            (Skill "Lightning Strikes3" "its a strike" (Just (Upgrade (Skill "Lightning Strikes L" "its a strike" Nothing) (Skill "Lightning Strikes R" "its a strike" Nothing))))
            (Skill "Lightning Strikes4" "its a strike" (Just (Upgrade (Skill "Lightning Strikes L" "its a strike" Nothing) (Skill "Lightning Strikes R" "its a strike" Nothing))))
            (Skill "Lightning Strikes5" "its a strike" (Just (Upgrade (Skill "Lightning Strikes L" "its a strike" Nothing) (Skill "Lightning Strikes R" "its a strike" Nothing))))
        )


heroes : List Hero
heroes =
    [ tripp
    ]
