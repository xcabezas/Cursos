codeunit 50101 "IUSUP Course Journal-Post Line"
{
    Permissions = TableData "IUSUP Course Ledger Entry" = rimd;
    TableNo = "IUSUP Course Journal Line";

    trigger OnRun()
    begin
        GetGLSetup();
        RunWithCheck(Rec);
    end;

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        CourseJournalLineGlobal: Record "IUSUP Course Journal Line";
        CourseLedgerEntry: Record "IUSUP Course Ledger Entry";
        Course: Record "IUSUP Course";
        NextEntryNo: Integer;
        GLSetupRead: Boolean;

    procedure RunWithCheck(var CourseJournalLine: Record "IUSUP Course Journal Line")
    begin
        CourseJournalLineGlobal.Copy(CourseJournalLine);
        Code();
        CourseJournalLine := CourseJournalLineGlobal;
    end;

    local procedure "Code"()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforePostCourseJnlLine(CourseJournalLineGlobal, IsHandled);
        if not IsHandled then begin
            if CourseJournalLineGlobal.EmptyLine() then
                exit;

            if NextEntryNo = 0 then begin
                CourseLedgerEntry.LockTable();
                NextEntryNo := CourseLedgerEntry.GetLastEntryNo() + 1;
            end;

            if CourseJournalLineGlobal."Document Date" = 0D then
                CourseJournalLineGlobal."Document Date" := CourseJournalLineGlobal."Posting Date";

            Course.Get(CourseJournalLineGlobal."Course No.");

            CourseLedgerEntry.Init();
            CourseLedgerEntry.CopyFromCourseJournalLine(CourseJournalLineGlobal);

            GetGLSetup();
            CourseLedgerEntry."Total Price" := Round(CourseLedgerEntry."Total Price");
            CourseLedgerEntry."Entry No." := NextEntryNo;

            OnBeforeCourseLedgerEntryInsert(CourseLedgerEntry, CourseJournalLineGlobal);

            CourseLedgerEntry.Insert(true);

            NextEntryNo := NextEntryNo + 1;
        end;

        OnAfterPostCourseJournalLine(CourseJournalLineGlobal, CourseLedgerEntry);
    end;

    local procedure GetGLSetup()
    begin
        if not GLSetupRead then
            GeneralLedgerSetup.Get();
        GLSetupRead := true;
    end;


    [IntegrationEvent(false, false)]
    local procedure OnAfterPostCourseJournalLine(var CourseJournalLine: Record "IUSUP Course Journal Line"; var CourseLedgerEntry: Record "IUSUP Course Ledger Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostCourseJnlLine(var CourseJournalLine: Record "IUSUP Course Journal Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCourseLedgerEntryInsert(var CourseLedgerEntry: Record "IUSUP Course Ledger Entry"; CourseJournalLine: Record "IUSUP Course Journal Line")
    begin
    end;
}