table 50102 "Course Edition"
{
    CaptionML = ENU = 'Course Edition', ESP = 'Edición Curso';

    fields
    {
        field(1; "Course No."; Code[20])
        {
            CaptionML = ENU = 'Course No.', ESP = 'Nº Curso';
            TableRelation = Course;
        }
        field(2; "Edition"; Code[20])
        {
            CaptionML = ENU = 'Edition', ESP = 'Edición';
        }
        field(3; "Start Date"; Date)
        {
            CaptionML = ENU = 'Start Date', ESP = 'Fecha Inicio';
        }
        field(4; "Max. Students"; Integer)
        {
            CaptionML = ENU = 'Max. Students', ESP = 'Nº Max. Alumnos';
        }
    }
    keys
    {
        key(PK; "Course No.", Edition)
        {
            Clustered = true;
        }
    }

}