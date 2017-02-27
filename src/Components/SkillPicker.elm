module Components.SkillPicker exposing (..)

import Components.SkillPickerUpgrade as SkillPickerUpgrade
import Types.Heroes as Heroes exposing (..)
import Types.Skills as Skills exposing (..)
import Utils.Skills as SkillUtils exposing (..)
import Utils.Markup exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


type Action
    = Highlight Skill
    | SkillUpgradeAction SkillPickerUpgrade.Action


type UpgradePath
    = Left
    | Right


update :
    Action
    -> { a | highlightedSkill : Maybe Skill, selectedUpgrades : List Skill }
    -> ( { a | highlightedSkill : Maybe Skill, selectedUpgrades : List Skill }, Cmd Action )
update action state =
    case action of
        Highlight skill ->
            --let
            --    nextHighlightedSkill =
            --        case state.highlightedSkill of
            --            Just highlightedSkill ->
            --                if skill == highlightedSkill then Nothing else Just skill
            --            Nothing ->
            --                Just skill
            --in
            ( { state
                | highlightedSkill = Just skill
              }
            , Cmd.none
            )

        SkillUpgradeAction upgradeAction ->
            let
                ( skillUpgradeState, skillUpgradeCmd ) =
                    SkillPickerUpgrade.update upgradeAction state
            in
                ( skillUpgradeState
                , Cmd.map SkillUpgradeAction skillUpgradeCmd
                )


viewSkillPicker : (Action -> a) -> Hero -> Maybe Skill -> List Skill -> Html a
viewSkillPicker context hero mbHighlightedSkill selectedUpgrades =
    div [ class "row action-bar", id "skill-picker" ]
        [ viewSkillPickerNode context "lmb" hero.name hero.skills.lmb (isHighlighted hero.skills.lmb mbHighlightedSkill) selectedUpgrades
        , viewSkillPickerNode context "rmb" hero.name hero.skills.rmb (isHighlighted hero.skills.rmb mbHighlightedSkill) selectedUpgrades
        , viewSkillPickerNode context "q" hero.name hero.skills.q (isHighlighted hero.skills.q mbHighlightedSkill) selectedUpgrades
        , viewSkillPickerNode context "e" hero.name hero.skills.e (isHighlighted hero.skills.e mbHighlightedSkill) selectedUpgrades
        , viewSkillPickerNode context "f" hero.name hero.skills.f (isHighlighted hero.skills.f mbHighlightedSkill) selectedUpgrades
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
viewSkillPickerNode context key heroName skill isHighlighted selectedUpgrades =
    div
        [ class
            ("action-bar-skill hot"
                ++ (if isHighlighted then
                        " highlighted glowing-border"
                    else
                        ""
                   )
            )
        , onClick (context (Highlight skill))
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
            SkillPickerUpgrade.viewSkillPickerUpgrade (context << SkillUpgradeAction) skill.upgrades selectedUpgrades
          else
            text ""
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


viewUpgradeChildren : UpgradePair -> List Skill -> List (Html a)
viewUpgradeChildren upgrades selectedUpgrades =
    [ viewMiniTreeUpgrade Left upgrades selectedUpgrades
    , viewMiniTreeUpgrade Right upgrades selectedUpgrades
    ]


viewMiniTreeUpgrade : UpgradePath -> UpgradePair -> List Skill -> Html a
viewMiniTreeUpgrade side (UpgradePair left right) selectedUpgrades =
    let
        upgrade =
            case side of
                Left ->
                    left

                Right ->
                    right
    in
        div
            [ class (selectedClass (isSkillUpgradeSelected upgrade selectedUpgrades))
            ]
            -- unpack our upgrade children
            (case upgrade.upgrades of
                Just subUpgrades ->
                    viewUpgradeChildren subUpgrades selectedUpgrades

                Nothing ->
                    []
            )
