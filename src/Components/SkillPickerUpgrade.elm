module Components.SkillPickerUpgrade exposing (..)

import Types.Skills as Skills exposing (..)
import Utils.Skills as SkillUtils exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


viewSkillPickerUpgrade : Maybe UpgradePair -> List Skill -> Html a
viewSkillPickerUpgrade mbUpgrades selectedUpgrades =
    case mbUpgrades of
        Just upgrades ->
            case upgrades of
                UpgradePair left right ->
                    let
                        isLeftSelected =
                            (isSkillUpgradeSelected left selectedUpgrades)

                        isRightSelected =
                            (isSkillUpgradeSelected right selectedUpgrades)

                        isLeftSiblingSelected =
                            (isSkillSiblingUpgradeSelected left upgrades selectedUpgrades)

                        isRightSiblingSelected =
                            (isSkillSiblingUpgradeSelected right upgrades selectedUpgrades)
                    in
                        div []
                            [ viewUpgrade Left left upgrades isLeftSelected isLeftSiblingSelected selectedUpgrades
                            , viewUpgrade Right right upgrades isRightSelected isRightSiblingSelected selectedUpgrades
                            ]

        Nothing ->
            text ""


viewUpgrade : UpgradePath -> Skill -> UpgradePair -> Bool -> Bool -> List Skill -> Html a
viewUpgrade side skill upgradePair isSelected isSiblingSelected selectedUpgrades =
    div [ class ("action-bar-upgrade" ++ selectedClass isSelected ++ sibSelectedClass isSiblingSelected) ]
        [ viewUpgradeLines side skill isSelected
        , if isSelected then
            viewUpgradeCheckmark skill
          else
            text ""
        , dl []
            [ dt []
                [ text skill.name ]
            , dd [ attribute "desc" "upgrade.desc", attribute "game-tips" "" ]
                []
            ]
        , if isSelected then
            viewSkillPickerUpgrade skill.upgrades selectedUpgrades
          else
            text ""
        ]


viewUpgradeCheckmark : Skill -> Html msg
viewUpgradeCheckmark skill =
    div [ class "upgrade-selected" ]
        [ span [ class "glyphicon glyphicon-ok" ]
            []
        ]


viewUpgradeLines : UpgradePath -> Skill -> Bool -> Html msg
viewUpgradeLines side skill isSelected =
    div [ class ("lines " ++ (whichTree side) ++ (selectedClass isSelected)) ]
        [ div [ class "line vertical root" ]
            []
        , div [ class "line horizontal" ]
            []
        , if isSelected then
            div [ class "line vertical branch" ]
                []
          else
            text ""
        ]


whichTree : UpgradePath -> String
whichTree side =
    case side of
        Left ->
            "left-tree"

        Right ->
            "right-tree"


selectedClass : Bool -> String
selectedClass isSelected =
    if isSelected then
        " selected"
    else
        ""


sibSelectedClass : Bool -> String
sibSelectedClass isSelected =
    if isSelected then
        " sib-selected"
    else
        ""
