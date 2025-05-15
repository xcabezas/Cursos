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
            trigger OnAfterValidate()
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
            begin
                CheckCourseEditionMaxStudents();
            end;
        }
    }

    local procedure CheckCourseEditionMaxStudents()
    var
        CourseEdition: Record "IUSUP Course Edition";
        CourseLedgerEntry: Record "IUSUP Course Ledger Entry";
        PreviousSales: Decimal;
    begin
        if Rec.Type <> Rec.Type::"IUSUP Course" then
            exit;

        if Rec."IUSUP Course Edition" = '' then
            exit;

        CourseEdition.SetLoadFields("Max. Students");
        CourseEdition.Get(Rec."No.", Rec."IUSUP Course Edition");

        CourseLedgerEntry.SetRange("Course No.", Rec."No.");
        CourseLedgerEntry.SetRange("Course Edition", Rec."IUSUP Course Edition");
        CourseLedgerEntry.SetLoadFields(Quantity);
        if CourseLedgerEntry.FindSet() then
            repeat
                PreviousSales := PreviousSales + CourseLedgerEntry.Quantity;
            until CourseLedgerEntry.Next() = 0;

        if (PreviousSales + Rec.Quantity) > CourseEdition."Max. Students" then
            Message('Con las ventas previas (%1) más la venta actual (%2) para el curso %3 y edición %4, se superaría el número máximo de alumnos (%5)',
                PreviousSales, Rec.Quantity, Rec."No.", Rec."IUSUP Course Edition", CourseEdition."Max. Students");
    end;
}