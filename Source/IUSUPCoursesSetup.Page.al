page 50102 "IUSUP Courses Setup"
{
    AccessByPermission = TableData "IUSUP Course" = R;
    ApplicationArea = All;
    Caption = 'Courses Setup', Comment = 'ESP="Configuración Setup"';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "IUSUP Course Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {

            group(Numbering)
            {
                Caption = 'Numbering', Comment = 'ESP="Numeración"';
                field("Course Nos."; Rec."Course Nos.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the number series code you can use to assign numbers to Courses.', Comment = 'ESP="Especifica el código de serie que quieres asignar a los cursos"';
                }

            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
