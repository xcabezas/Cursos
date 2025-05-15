tableextension 50100 "IUSUP Sales Line" extends "Sales Line"
{
    fields
    {
        modify("No.")
        {
            TableRelation = if (Type = const("IUSUP Course")) "IUSUP Course";
        }
        modify(Quantity)
        {
            trigger OnBeforeValidate()
            var
                CourseEdition: Record "IUSUP Course Edition";

            begin
                CheckCourseEditionMaxStudents();
            end;
        }

        field(50100; "IUSUP Course Edition"; Code[20])
        {
            Caption = 'Course Edition', comment = 'ESP="Edición curso"';
            DataClassification = CustomerContent;
            TableRelation = "IUSUP Course Edition".Edition where("Course No." = field("No."));

            trigger OnValidate()
            var
                CourseEdition: Record "IUSUP Course Edition";
            begin
                CheckCourseEditionMaxStudents();
            end;
        }
    }
    local procedure CheckCourseEditionMaxStudents()
    var
        CourseEdition: Record "IUSUP Course Edition";
        CourseLedgerentry: Record "IUSUP Course Ledger Entry";
        PreviousSales: Decimal;


    begin
        if Rec.Type <> Rec.Type::"IUSUP Course" then
            exit;

        if Rec."IUSUP Course Edition" = '' then
            exit;

        CourseEdition.Get(Rec."No.", Rec."IUSUP Course Edition");

        CourseLedgerentry.SetRange("Course No.", Rec."No.");
        CourseLedgerentry.SetRange("Course Edition", Rec."IUSUP Course Edition");
        CourseLedgerentry.SetLoadFields(Quantity);
        if CourseLedgerentry.FindSet() then
            repeat
                PreviousSales := PreviousSales + CourseLedgerentry.Quantity;

            until CourseLedgerentry.Next() = 0;

        if (PreviousSales + Rec.Quantity) > CourseEdition."Max. Students" then
            Message(
                'Con las ventas previas (%1) mas la venta actual (%2) para el curso %3 y edición %4, se superaría el numero màximo de alumnos (%5)',
                PreviousSales, Rec.Quantity, Rec."No.", Rec."IUSUP Course Edition", CourseEdition."Max. Students");

    end;
}