page 50100 "IUSUP Course List"
{
    Caption = 'Courses', Comment = 'ESP="Cursos"';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "IUSUP Course";
    Editable = false;
    CardPageId = "IUSUP Course Card";

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field("No."; Rec."No.") { }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Manufacturing;
                }
                field("Duration (hours)"; Rec.Hours) { }
                field(Price; Rec.Price) { }
                field("Language Code"; Rec."Language Code") { }
                field("Type (Enum)"; Rec."Type (Enum)") { }
            }
        }
        area(FactBoxes)
        {
            part(Editions; "IUSUP Course Editions Factbox")
            {
                SubPageLink = "Course No." = field("No.");
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