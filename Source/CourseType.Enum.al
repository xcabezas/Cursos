enum 50100 "Course Type"
{
    Extensible = true;
    CaptionML = ENU = 'Course Type', ESP = 'Tipo Curso';

    value(0; " ") { }

    value(1; "Instructor-lead")
    {
        CaptionML = ENU = 'Instructor-lead', ESP = 'Guiador por profesor';

    }

    value(2; "Video Tutorial")
    {
        CaptionML = ENU = 'Video Tutorial', ESP = 'Video Tutorial';

    }
}