enum 50100 "IUSUP Course Type"
{
    Extensible = true;
    Caption = 'Course Type', Comment = 'ESP="Tipo Curso"';

    value(0; " ") { }

    value(1; "Instructor-lead")
    {
        Caption = 'Instructor-lead', Comment = 'ESP="Guiador por profesor"';

    }

    value(2; "Video Tutorial")
    {
        Caption = 'Video Tutorial', Comment = 'ESP="Video Tutorial"';

    }
}