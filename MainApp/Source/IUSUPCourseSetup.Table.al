table 50101 "IUSUP Course Setup"
{
    Caption = 'Courses Setup', Comment = 'ESP="Configuración Cursos"';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Course Nos."; Code[20])
        {
            Caption = 'Course Nos.', Comment = 'ESP="Nº Cursos"';
            TableRelation = "No. Series";
        }

    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

}