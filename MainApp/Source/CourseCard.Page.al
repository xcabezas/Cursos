page 50101 "IUSUP Course Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "IUSUP Course";
    Caption = 'Course Card', Comment = 'ESP="Ficha Curso"';


    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'ESP="General"';

                field("No."; Rec."No.")
                {
                    Caption = 'No. from caption', Comment = 'ESP="Nº"';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name', Comment = 'ESP="Nombre"';
                }

            }
            group(TrainingDetails)
            {
                Caption = 'TrainingDetails', Comment = 'ESP="Detalles de Entrenamiento"';

                field(Description; Rec.Description)
                {
                    Caption = 'Description', Comment = 'ESP="Descripción"';
                }
                field(Hours; Rec.Hours)
                {
                    Caption = 'Hours', Comment = 'ESP="Horas"';
                }
                field("Language Code"; Rec."Language Code")
                {
                    Caption = 'Language Code', Comment = 'ESP="Codigo de Lenguage"';

                }
                field("Type (Enum)"; Rec."Type (Enum)")
                {
                    Caption = 'Type (Enum)', Comment = 'ESP="Tipo (Enum)"';

                }
                field("Type (Option)"; Rec."Type (Option)")
                {

                }

            }
            part(Editions; "IUSUP Course Editions Factbox")
            {
                SubPageLink = "Course No." = field("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing', Comment = 'ESP="Facturación"';

                field(Price; Rec.Price)
                {

                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {

                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {

                }
            }

        }

    }
    actions
    {
        area(Navigation)
        {
            action(CourseEditions)
            {
                Caption = 'Editions', Comment = 'ESP="Ediciones"';
                Image = List;
                RunObject = page "IUSUP Course Editions";
                RunPageLink = "Course No." = field("No.");
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action("Ledger E&ntries")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Ledger E&ntries';
                    Image = ResourceLedger;
                    RunObject = Page "IUSUP Course Ledger Entries";
                    RunPageLink = "Course No." = field("No.");
                    RunPageView = sorting("Course No.")
                                   order(descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
            }
        }
        area(Promoted)
        {
            group(Category_Category4)
            {
                Caption = 'MyCategory', Comment = 'ESP="MiCategoria"';
                ShowAs = SplitButton;

                actionref(CourseEditions_Promoted; CourseEditions)
                {
                }
                actionref(LedgerEntries_Promoted; "Ledger E&ntries")
                { }
            }
        }
    }

}