pageextension 50103 "IUSUP Sales Invoice Subform" extends "Sales Invoice Subform"
{
    layout
    {
        addafter("No.")
        {
            field("IUSUP Course Edition"; Rec."IUSUP Course Edition") { ApplicationArea = All; }



        }
    }


}