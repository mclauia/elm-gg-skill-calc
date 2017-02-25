module Components.SkillPickerUpgrade exposing (..)

import Types.Skills as Skills exposing (..)
import Utils.Skills as SkillUtils exposing (..)
import Utils.Markup exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


type Action = SelectSkillUpgrade Skill

update : Action -> a -> (a, Cmd a)
update action state =
    case action of
        SelectSkillUpgrade skill ->
            ( state
            , Cmd.none
            )

viewSkillPickerUpgrade : (Action -> a) -> Maybe UpgradePair -> List Skill -> Html a
viewSkillPickerUpgrade context mbUpgrades selectedUpgrades =
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
                            [ viewUpgrade context Left left upgrades isLeftSelected isLeftSiblingSelected selectedUpgrades
                            , viewUpgrade context Right right upgrades isRightSelected isRightSiblingSelected selectedUpgrades
                            ]

        Nothing ->
            text ""


viewUpgrade context side skill upgradePair isSelected isSiblingSelected selectedUpgrades =
    div [ class ("action-bar-upgrade" ++ selectedClass isSelected ++ sibSelectedClass isSiblingSelected)
    , onClick (context (SelectSkillUpgrade skill))
     ]
        [ viewUpgradeLines side skill isSelected
        , if isSelected then
            viewUpgradeCheckmark skill
          else
            text ""
        , dl []
            [ dt []
                [ text skill.name ]
            , viewSkillDescription skill.description
            ]
        , if isSelected then
            viewSkillPickerUpgrade context skill.upgrades selectedUpgrades
          else
            text ""
        ]


-- @todo text parsing / formatting / tooltipping in here
viewSkillDescription : String -> Html msg
viewSkillDescription description =
    dd [ ]
        [ text description
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

