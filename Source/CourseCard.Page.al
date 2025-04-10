page 50101 "Course Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Course;
    CaptionML = ENU = 'Course Card', ESP = 'Ficha Curso';


    layout
    {
        area(Content)
        {
            group(General)
            {
                CaptionML = ENU = 'General', ESP = 'General';

                field("No."; Rec."No.")
                {
                    CaptionML = ENU = 'No. from caption', ESP = 'Nº';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Name; Rec.Name)
                {
                    CaptionML = ENU = 'Name', ESP = 'Nombre';
                }

            }
            group(TrainingDetails)
            {
                CaptionML = ENU = 'TrainingDetails', ESP = 'Detalles de Entrenamiento';

                field(Description; Rec.Description)
                {
                    CaptionML = ENU = 'Description', ESP = 'Descripción';
                }
                field(Hours; Rec.Hours)
                {
                    CaptionML = ENU = 'Hours', ESP = 'Horas';
                }
                field("Language Code"; Rec."Language Code")
                {
                    CaptionML = ENU = 'Language Code', ESP = 'Codigo de Lenguage';

                }
                field("Type (Enum)"; Rec."Type (Enum)")
                {
                    CaptionML = ENU = 'Type (Enum)', ESP = 'Tipo (Enum)';

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
                CaptionML = ENU = 'Invoicing', ESP = 'Facturación';

                field(Price; Rec.Price)
                {

                }
            }
        }
    }

}