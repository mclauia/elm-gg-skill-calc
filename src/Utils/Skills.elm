module Utils.Skills exposing (..)

import Types.Skills as Skills exposing (..)


isSkillUpgradeSelected : Skill -> List Skill -> Bool
isSkillUpgradeSelected upgrade selectedUpgrades =
    List.any (\selectedUpgrade -> upgrade == selectedUpgrade) selectedUpgrades


isSkillSiblingUpgradeSelected skill (UpgradePair left right) selectedUpgrades =
    if skill == left then
        isSkillUpgradeSelected right selectedUpgrades
    else
        isSkillUpgradeSelected left selectedUpgrades
