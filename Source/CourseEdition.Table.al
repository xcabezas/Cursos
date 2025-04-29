table 50102 "IUSUP Course Edition"
{
    Caption = 'Course Edition', Comment = 'ESP="Edición Curso"';
    DataClassification = CustomerContent;
    LookupPageId = "IUSUP Course Editions";

    fields
    {
        field(1; "Course No."; Code[20])
        {
            Caption = 'Course No.', Comment = 'ESP="Nº Curso"';
            TableRelation = "IUSUP Course";

        }
        field(2; Edition; Code[20])
        {
            Caption = 'Edition', Comment = 'ESP="Edición"';
        }
        field(3; "Start Date"; Date)
        {
            Caption = 'Start Date', Comment = 'ESP="Fecha Inicio"';
        }
        field(4; "Max. Students"; Integer)
        {
            Caption = 'Max. Students', Comment = 'ESP="Nº Max. Alumnos"';
        }
    }
    keys
    {
        key(PK; "Course No.", Edition)
        {
            Clustered = true;

        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Edition, "Max. Students", "Start Date")
        {

        }
        fieldgroup(Brick; "Max. Students", Edition)
        {

        }
    }

}