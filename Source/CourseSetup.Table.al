table 50101 "Course Setup"
{
    CaptionML = ENU = 'Courses Setup', ESP = 'Configuración Cursos';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Course Nos."; Code[20])
        {
            CaptionML = ENU = 'Course Nos.', ESP = 'Nº Cursos';
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