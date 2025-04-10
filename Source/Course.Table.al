table 50100 Course
{

    CaptionML = ENU = 'Course Table', ESP = 'Tabla Curso';

    fields
    {
        field(1; "No."; Code[20])
        {
            CaptionML = ENU = 'No. from caption', ESP = 'Nº';

            trigger OnValidate()
            var
                IsHandled: Boolean;
                ResSetup: Record "Course Setup";
                NoSeries: Codeunit "No. Series";
            begin
                IsHandled := false;
                OnBeforeValidateNo(Rec, xRec, IsHandled);
                if IsHandled then
                    exit;

                if "No." <> xRec."No." then begin
                    ResSetup.Get();
                    NoSeries.TestManual(ResSetup."Course Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Name"; Text[100])
        {
            CaptionML = ENU = 'Name', ESP = 'Nombre';
        }
        field(3; "Description"; Text[2048])
        {
            CaptionML = ENU = 'Description', ESP = 'Descripción';
        }
        field(4; "Hours"; Integer)
        {
            CaptionML = ENU = 'Hours', ESP = 'Horas';
        }
        field(5; "Price"; Decimal)
        {
            CaptionML = ENU = 'Price', ESP = 'Precio';
        }
        field(6; "Language Code"; Code[20])
        {
            TableRelation = Language;
            CaptionML = ENU = 'Language Code', ESP = 'Codigo de Lenguage';

        }
        field(7; "Type (Option)"; Option)
        {
            OptionMembers = " ","Instructor-Lead","Video Tutorial";
            CaptionML = ENU = 'Type (Option)', ESP = 'Tipo (Opcion)';
            OptionCaptionML = ENU = ' ,Instructor-Lead, Video Tutorial', ESP = ' ,Guiador por profesor, Video Tutorial';

        }
        field(8; "Type (Enum)"; Enum "Course Type")
        {
            CaptionML = ENU = 'Type (Enum)', ESP = 'Tipo (Enum)';
        }
        field(56; "No. Series"; Code[20])
        {
            CaptionMl = ENU = 'No. Series', ESP = 'Nº Serie';
            Editable = false;
            TableRelation = "No. Series";
        }

    }

    trigger OnInsert()
    var
        Resource: Record Course;
        IsHandled: Boolean;
        ResSetup: Record "Course Setup";
        NoSeries: Codeunit "No. Series";
    begin
        IsHandled := false;
        OnBeforeOnInsert(Rec, IsHandled, xRec);
        if IsHandled then
            exit;

        if "No." = '' then begin
            ResSetup.Get();
            ResSetup.TestField("Course Nos.");
            "No. Series" := ResSetup."Course Nos.";
            if NoSeries.AreRelated("No. Series", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeries.GetNextNo("No. Series");
            Resource.ReadIsolation(IsolationLevel::ReadUncommitted);
            Resource.SetLoadFields("No.");
            while Resource.Get("No.") do
                "No." := NoSeries.GetNextNo("No. Series");

        end;
    end;


    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsert(var Resource: Record Course; var IsHandled: Boolean; var xResource: Record Course)
    begin
    end;

    procedure AssistEdit(OldRes: Record Course) Result: Boolean
    var
        IsHandled: Boolean;
        ResSetup: Record "Course Setup";
        Res: Record Course;
        NoSeries: Codeunit "No. Series";


    begin
        IsHandled := false;
        OnBeforeAssistEdit(Rec, OldRes, IsHandled, Result);
        if IsHandled then
            exit(Result);

        Res := Rec;
        ResSetup.Get();
        ResSetup.TestField("Course Nos.");
        if NoSeries.LookupRelatedNoSeries(ResSetup."Course Nos.", OldRes."No. Series", Res."No. Series") then begin
            Res."No." := NoSeries.GetNextNo(Res."No. Series");
            Rec := Res;
            exit(true);
        end;
    end;


    [IntegrationEvent(false, false)]
    local procedure OnBeforeAssistEdit(var Resource: Record Course; xOldRes: Record Course; var IsHandled: Boolean; var Result: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateNo(var Resource: Record Course; xResource: Record Course; var IsHandled: Boolean)
    begin
    end;

}
