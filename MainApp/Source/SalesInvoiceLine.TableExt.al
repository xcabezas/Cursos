tableextension 50102 "IUSUP Sales Invoice Line" extends "Sales Invoice Line"
{
    fields
    {
        modify("No.")
        {
            TableRelation = if (Type = const("IUSUP Course")) "IUSUP Course";

        }
        field(50100; "IUSUP Course Edition"; Code[20])
        {
            Caption = 'Course Edition', comment = 'Edición de Curso';
            DataClassification = CustomerContent;
            TableRelation = "IUSUP Course Edition".Edition where("Course No." = field("No."));
        }
    }
}