tableextension 50100 "IUSUP Sales Line" extends "Sales Line"
{
    fields
    {
        modify("No.")
        {
            TableRelation = if (Type = const("IUSUP Course")) "IUSUP Course";
        }
        field(50100; "IUSUP Course Edition"; Code[20])
        {
            Caption = 'Course Edition', comment = 'ESP="Edición curso"';
            DataClassification = CustomerContent;
            TableRelation = "IUSUP Course Edition".Edition where("Course No." = field("No."));
        }
    }
}