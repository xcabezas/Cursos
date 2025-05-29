pageextension 50107 "IUSUP Customer Card" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("IUSUP Customer Level"; Rec."IUSUP Customer Level")
            {
                ApplicationArea = All;
            }
            field("IUSUP Discount"; Rec."IUSUP Discount")
            {
                ApplicationArea = All;
            }
        }
    }
}