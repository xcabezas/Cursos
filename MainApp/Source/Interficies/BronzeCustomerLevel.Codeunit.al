codeunit 50103 "IUSUPBronze Customer Level" implements IUSUPCustomerLevel
{
    procedure GetDiscount(): Decimal
    begin
        exit(5);
    end;

    procedure SendEmail()
    begin

    end;
}