table 50100 "IUSUP Course"
{

    Caption = 'Course Table', Comment = 'ESP="Tabla Curso"';
    DataClassification = CustomerContent;
    LookupPageId = "IUSUP Course List";
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No. from caption', Comment = 'ESP="Nº", FRA="Numero"';

            trigger OnValidate()
            var
                IsHandled: Boolean;
                ResSetup: Record "IUSUP Course Setup";
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
        field(2; Name; Text[100])
        {
            Caption = 'Name', Comment = 'ESP="Nombre"';
        }
        field(3; Description; Text[2048])
        {
            Caption = 'Description', Comment = 'ESP="Descripción"';
        }
        field(4; Hours; Integer)
        {
            Caption = 'Hours', Comment = 'ESP="Horas"';
        }
        field(5; Price; Decimal)
        {
            Caption = 'Price', Comment = 'ESP="Precio"';
        }
        field(6; "Language Code"; Code[20])
        {
            TableRelation = Language;
            Caption = 'Language Code', Comment = 'ESP="Codigo de Lenguage"';

        }
        field(7; "Type (Option)"; Option)
        {
            OptionMembers = " ","Instructor-Lead","Video Tutorial";
            Caption = 'Type (Option)', Comment = 'ESP="Tipo (Opcion)"';
            OptionCaption = ' ,Instructor-Lead, Video Tutorial', Comment = 'ESP=" ,Guiador por profesor, Video Tutorial"';

        }
        field(8; "Type (Enum)"; Enum "IUSUP Course Type")
        {
            Caption = 'Type (Enum)', Comment = 'ESP="Tipo (Enum)"';
        }
        field(56; "No. Series"; Code[20])
        {
            Caption = 'No. Series', Comment = 'ESP="Nº Serie"';
            Editable = false;
            TableRelation = "No. Series";
        }

        field(51; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group', Comment = 'ESP="Grupo contable prod. gen."';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            var
                GenProdPostingGrp: Record "Gen. Product Posting Group";
            begin
                if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
                    if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp, "Gen. Prod. Posting Group") then
                        Validate("VAT Prod. Posting Group", GenProdPostingGrp."Def. VAT Prod. Posting Group");
            end;
        }
        field(58; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }

    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, Description, Price, Hours, "Language Code")
        {

        }
        fieldgroup(Brick; "No.", Name, Price)
        {

        }
    }

    trigger OnInsert()
    var
        Resource: Record "IUSUP Course";
        IsHandled: Boolean;
        ResSetup: Record "IUSUP Course Setup";
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
    local procedure OnBeforeOnInsert(var Resource: Record "IUSUP Course"; var IsHandled: Boolean; var xResource: Record "IUSUP Course")
    begin
    end;

    procedure AssistEdit(OldRes: Record "IUSUP Course") Result: Boolean
    var
        IsHandled: Boolean;
        ResSetup: Record "IUSUP Course Setup";
        Res: Record "IUSUP Course";
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
    local procedure OnBeforeAssistEdit(var Resource: Record "IUSUP Course"; xOldRes: Record "IUSUP Course"; var IsHandled: Boolean; var Result: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateNo(var Resource: Record "IUSUP Course"; xResource: Record "IUSUP Course"; var IsHandled: Boolean)
    begin
    end;

}
