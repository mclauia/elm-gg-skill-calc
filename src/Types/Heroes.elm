module Types.Heroes exposing (..)

import Types.Skills as Skills exposing (..)


type alias Hero =
    { name : String
    , skills : SkillSet
    }


tripp : Hero
tripp =
    Hero "Tripp"
        (SkillSet
            (lightningStrikes)
            (Skill "Lightning Strikes 2" "its a strike" (Just (Upgrades (Skill "Lightning Strikes 2L" "its a strike" Nothing) (Skill "Lightning Strikes 2R" "its a strike" Nothing))))
            (Skill "Lightning Strikes3" "its a strike" (Just (Upgrades (Skill "Lightning Strikes 3L" "its a strike" Nothing) (Skill "Lightning Strikes 3R" "its a strike" Nothing))))
            (Skill "Lightning Strikes4" "its a strike" (Just (Upgrades (Skill "Lightning Strikes 4L" "its a strike" Nothing) (Skill "Lightning Strikes 4R" "its a strike" Nothing))))
            (Skill "Lightning Strikes5" "its a strike" (Just (Upgrades (Skill "Lightning Strikes 5L" "its a strike" Nothing) (Skill "Lightning Strikes 5R" "its a strike" Nothing))))
        )


lightningStrikes =
    Skill
        "Lightning Strikes 1"
        "its a strike"
        (Just (Upgrades powerSurge unseenStrike))


powerSurge =
    Skill "Power Surge"
        "its a dddddd"
        (Just (Upgrades overload fullCharge))


overload =
    Skill "overload" "its a dddddd" Nothing


fullCharge =
    Skill "fullCharge" "its a dddddd" Nothing


unseenStrike =
    Skill "Unseen Strike"
        "its a ssssss"
        (Just (Upgrades assassinsCredo arterialRout))


assassinsCredo =
    Skill "Assassin's Credo" "its a dddddd" Nothing


arterialRout =
    Skill "Arterial Rout" "its a dddddd" Nothing


heroes : List Hero
heroes =
    [ tripp
    ]
