module Components.SkillPickerUpgrade exposing (..)

import Types.Skills as Skills exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


viewSkillPickerUpgrade : Maybe Upgrades -> Html a
viewSkillPickerUpgrade mbUpgrades =
    case mbUpgrades of
        Just upgrades ->
            case upgrades of
                Upgrades left right ->
                    div []
                        [ viewUpgrade Left left
                        , viewUpgrade Right right
                        ]

        Nothing ->
            text ""


viewUpgrade side skill =
    div [ class "action-bar-upgrade" ]
        [ viewUpgradeLines side
        , div [ class "upgrade-selected", attribute "ng-show" "isSelected(upgrade)" ]
            [ span [ class "glyphicon glyphicon-ok" ]
                []
            ]
        , dl []
            [ dt []
                [ text "{{upgrade.name}}" ]
            , dd [ attribute "desc" "upgrade.desc", attribute "game-tips" "" ]
                []
            ]
        , viewSkillPickerUpgrade skill.upgrades
        ]


viewUpgradeLines side =
    div [ class ("lines " ++ (whichTree side)) ]
        [ div [ class "line vertical root" ]
            []
        , div [ class "line horizontal" ]
            []
        , div [ class "line vertical branch" ]
            []
        ]


whichTree side =
    case side of
        Left ->
            "left-tree"

        Right ->
            "right-tree"
