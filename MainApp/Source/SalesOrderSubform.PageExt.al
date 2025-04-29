pageextension 50100 "IUSUP Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field("IUSUP Course Edition"; Rec."IUSUP Course Edition") { ApplicationArea = All; }



        }
    }


}