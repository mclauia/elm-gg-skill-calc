module Utils.Markup exposing (..)

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
