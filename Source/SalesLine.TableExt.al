tableextension 50100 "IUSUP Sales Line" extends "Sales Line"
{
    fields
    {
        modify("No.")
        {
            TableRelation = if (Type = const("IUSUP Course")) "IUSUP Course";

        }
    }
}