tableextension 50104 "IUSUP Customer" extends Customer
{
    fields
    {
        field(50100; "IUSUP Customer Level"; Enum "IUSUP Customer Level")
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ICustomerLevel: Interface IUSUPCustomerLevel;
            begin
                ICustomerLevel := Rec."IUSUP Customer Level";
                Rec."IUSUP Discount" := ICustomerLevel.GetDiscount();
            end;
        }
        field(50101; "IUSUP Discount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
}