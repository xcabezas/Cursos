page 50105 "IUSUP Application Area"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Application Area Setup";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Basic; Rec.Basic) { }
                field("Fixed Assets"; Rec."Fixed Assets") { }
            }
        }
    }

}