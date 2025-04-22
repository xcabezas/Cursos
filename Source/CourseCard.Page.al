page 50101 "Course Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Course;
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
            part(Editions; "Course Editions Factbox")
            {
                SubPageLink = "Course No." = field("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing', Comment = 'ESP="Facturación"';

                field(Price; Rec.Price)
                {

                }
            }
        }
    }

}