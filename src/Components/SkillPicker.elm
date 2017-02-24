module Components.SkillPicker exposing (..)

import Types.Heroes as Heroes exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


type Action
    = Highlight Skill


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


viewSkillPicker : (Action -> a) -> Hero -> Maybe Skill -> Html a
viewSkillPicker actionContext hero mbHighlightedSkill =
    div [ class "row action-bar", id "skill-picker" ]
        [ viewSkillPickerNode actionContext "lmb" hero.name hero.skills.lmb (isHighlighted hero.skills.lmb mbHighlightedSkill)
        , viewSkillPickerNode actionContext "rmb" hero.name hero.skills.rmb (isHighlighted hero.skills.rmb mbHighlightedSkill)
        , viewSkillPickerNode actionContext "q" hero.name hero.skills.q (isHighlighted hero.skills.q mbHighlightedSkill)
        , viewSkillPickerNode actionContext "e" hero.name hero.skills.e (isHighlighted hero.skills.e mbHighlightedSkill)
        , viewSkillPickerNode actionContext "f" hero.name hero.skills.f (isHighlighted hero.skills.f mbHighlightedSkill)
          --, @todo passives
        ]


isHighlighted : Skill -> Maybe Skill -> Bool
isHighlighted skill mbHighlighted =
    case mbHighlighted of
        Just highlightedSkill ->
            highlightedSkill == skill

        Nothing ->
            False


viewSkillPickerNode : (Action -> a) -> String -> String -> Skill -> Bool -> Html a
viewSkillPickerNode actionContext key heroName skill isHighlighted =
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
        , div [ class "minitree" ]
            [ div []
                [ div []
                    []
                ]
            ]
        , div
            [ class ("hero-icon icon-lg " ++ String.toLower heroName ++ " " ++ key)
              --attribute "ng-mouseleave" "showTooltip = false", attribute "ng-mouseover" "showTooltip = true"
            ]
            []
        , div [ class "skill-available glowing-border" ]
            [ span [ class "glyphicon glyphicon-plus" ]
                []
            ]
        ]
