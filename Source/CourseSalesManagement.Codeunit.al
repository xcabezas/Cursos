codeunit 50100 "IUSUPCourse - Sales Management"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterAssignFieldsForNo, '', false, false)]
    local procedure OnAfterAssingFieldsForNo(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
        if SalesLine.Type = Enum::"Sales Line Type"::"IUSUP Course" then
            CopyFromCourse(SalesLine, SalesHeader);
    end;

    local procedure CopyFromCourse(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
        Course: Record "IUSUP Course";

    begin
        Course.Get(SalesLine."No.");
        SalesLine.Description := Course.Name;
        SalesLine."Allow Item Charge Assignment" := false;
        SalesLine."Unit Price" := Course.Price;
        SalesLine."Gen. Prod. Posting Group" := Course."Gen. Prod. Posting Group";
        SalesLine."VAT Prod. Posting Group" := Course."VAT Prod. Posting Group";
        OnAfterAssignCourseValues(SalesLine, Course, SalesHeader);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterAssignCourseValues(var SalesLine: Record "Sales Line"; Course: Record "IUSUP Course"; SalesHeader: Record "Sales Header")
    begin
    end;
}