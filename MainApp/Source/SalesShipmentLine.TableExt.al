tableextension 50101 "IUSUP Sales Shipment Line" extends "Sales Shipment Line"
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