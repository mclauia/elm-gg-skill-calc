module Components.SkillPicker exposing (..)

import Components.SkillPickerUpgrade as SkillPickerUpgrade exposing (viewSkillPickerUpgrade)
import Types.Heroes as Heroes exposing (..)
import Types.Skills as Skills exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Debug exposing (log)


type Action
    = Highlight Skill


type UpgradePath
    = Left
    | Right


update : Action -> { a | highlightedSkill : Maybe Skill } -> ( { a | highlightedSkill : Maybe Skill }, Cmd Action )
update action state =
    case action of
        Highlight skill ->
            --let
            --  nextThing = ManageAssets.update manageAction state
            --in
            ( { state
                | highlightedSkill = Just skill
              }
            , Cmd.none
            )


viewSkillPicker : (Action -> a) -> Hero -> Maybe Skill -> List Skill -> Html a
viewSkillPicker actionContext hero mbHighlightedSkill selectedUpgrades =
    div [ class "row action-bar", id "skill-picker" ]
        [ viewSkillPickerNode actionContext "lmb" hero.name hero.skills.lmb (isHighlighted hero.skills.lmb mbHighlightedSkill) selectedUpgrades
        , viewSkillPickerNode actionContext "rmb" hero.name hero.skills.rmb (isHighlighted hero.skills.rmb mbHighlightedSkill) selectedUpgrades
        , viewSkillPickerNode actionContext "q" hero.name hero.skills.q (isHighlighted hero.skills.q mbHighlightedSkill) selectedUpgrades
        , viewSkillPickerNode actionContext "e" hero.name hero.skills.e (isHighlighted hero.skills.e mbHighlightedSkill) selectedUpgrades
        , viewSkillPickerNode actionContext "f" hero.name hero.skills.f (isHighlighted hero.skills.f mbHighlightedSkill) selectedUpgrades
          --, @todo passives
        ]


isHighlighted : Skill -> Maybe Skill -> Bool
isHighlighted skill mbHighlighted =
    case mbHighlighted of
        Just highlightedSkill ->
            highlightedSkill == skill

        Nothing ->
            False


viewSkillPickerNode : (Action -> a) -> String -> String -> Skill -> Bool -> List Skill -> Html a
viewSkillPickerNode actionContext key heroName skill isHighlighted selectedUpgrades =
    div
        [ class
            ("action-bar-skill hot"
                ++ (if isHighlighted then
                        " highlighted glowing-border"
                    else
                        ""
                   )
            )
        , onClick (actionContext (Highlight skill))
        ]
        [ span [ class "skill-key fonted" ]
            [ text key ]
        , viewMiniTree skill selectedUpgrades
        , div
            [ class ("hero-icon icon-lg " ++ String.toLower heroName ++ " " ++ key)
              --attribute "ng-mouseleave" "showTooltip = false", attribute "ng-mouseover" "showTooltip = true"
            ]
            []
          -- @todo tooltip
        , div [ class "skill-available glowing-border" ]
            [ span [ class "glyphicon glyphicon-plus" ]
                []
            ]
        , if isHighlighted then
            SkillPickerUpgrade.viewSkillPickerUpgrade skill.upgrades
          else
            text ""
          -- @todo skill upgrade path
          --<skill-upgrade upgrades="skill.upgrades" class="fader" ng-show="isSkillHighlighted(skill)"></skill-upgrade>
        ]


viewMiniTree : Skill -> List Skill -> Html a
viewMiniTree skill selectedUpgrades =
    div [ class "minitree" ]
        (case skill.upgrades of
            Just upgrades ->
                viewUpgradeChildren upgrades selectedUpgrades

            Nothing ->
                []
        )


viewUpgradeChildren : Upgrades -> List Skill -> List (Html a)
viewUpgradeChildren upgrades selectedUpgrades =
    [ viewMiniTreeUpgrade Left upgrades selectedUpgrades
    , viewMiniTreeUpgrade Right upgrades selectedUpgrades
    ]


viewMiniTreeUpgrade : UpgradePath -> Upgrades -> List Skill -> Html a
viewMiniTreeUpgrade side upgrades selectedUpgrades =
    let
        upgrade =
            case upgrades of
                Upgrades left right ->
                    case side of
                        Left ->
                            left

                        Right ->
                            right
    in
        div
            [ class
                (if isSkillUpgradeSelected upgrade selectedUpgrades then
                    "selected"
                 else
                    ""
                )
            ]
            -- unpack our upgrade children
            (case upgrade.upgrades of
                Just subUpgrades ->
                    viewUpgradeChildren subUpgrades selectedUpgrades

                Nothing ->
                    []
            )


isSkillUpgradeSelected : Skill -> List Skill -> Bool
isSkillUpgradeSelected upgrade selectedUpgrades =
    let
        upgrade_ =
            log "upgrade" upgrade

        selectedUpgrades_ =
            (log "selectedUpgrades" selectedUpgrades)
    in
        List.any (\selectedUpgrade -> upgrade_ == selectedUpgrade) selectedUpgrades_


