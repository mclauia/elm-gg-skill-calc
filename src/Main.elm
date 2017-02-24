module Main exposing (..)

import Components.SkillPicker as SkillPicker exposing (viewSkillPicker)
import Types.Heroes as Heroes exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


--import Components.ManageAssets as ManageAssets
-- APP


main : Program Never State Action
main =
    Html.program
        { init = ( state, Cmd.none )
        , subscriptions = subscriptions
        , view = view
        , update = update
        }


subscriptions : a -> Sub b
subscriptions state =
    Sub.none



-- MODEL


type alias State =
    { selectedHero : Hero
    , highlightedSkill : Maybe Skill
    }


state : State
state =
    State tripp Nothing



-- UPDATE


type Action
    = SkillPickerAction SkillPicker.Action



--type Action = Manage ManageAssets.Action


update : Action -> State -> ( State, Cmd Action )
update action state =
    case action of
        SkillPickerAction skillPickerAction ->
            let
                ( skillPickerState, skillPickerCmd ) =
                    SkillPicker.update skillPickerAction state
            in
                ( skillPickerState
                , Cmd.map SkillPickerAction skillPickerCmd
                )



-- VIEW


view : State -> Html Action
view state =
    div []
        [ div [ class "row" ]
            [ div [ class "col-xs-12 form-inline" ]
                [ div [ class "row hero-card-row" ]
                    [ div [ class "col-xs-12" ]
                        (List.map (\hero -> viewHeroCard hero state.selectedHero) heroes)
                    ]
                , h1 []
                    [ text "Skill Calculator "
                    , small []
                        [ text "for" ]
                    , text state.selectedHero.name
                    ]
                  --, @todo import / export
                ]
            ]
        , div [ class "row skill-picker-row" ]
            [ div [ class "col-xs-10 col-xs-offset-2" ]
                [ SkillPicker.viewSkillPicker SkillPickerAction state.selectedHero state.highlightedSkill ]
            ]
        , div [ class "row" ]
            [ div [ class "col-xs-12" ]
                [ -- @todo timeline
                  div [ class "input-group" ]
                    []
                  -- @todo export
                ]
            ]
        ]


viewHeroCard : Hero -> Hero -> Html Action
viewHeroCard hero selectedHero =
    div [ class "hero-card-box" ]
        [ div
            [ class
                ("hero-card hero-portrait hot "
                    ++ String.toLower hero.name
                    ++ (if selectedHero.name == hero.name then
                            " selected"
                        else
                            ""
                       )
                )
            ]
            [ span [ class "hero-card-name fonted" ]
                [ text hero.name ]
            ]
        ]

