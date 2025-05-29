codeunit 50104 "IUSUPSilver Customer Level" implements IUSUPCustomerLevel
{
    procedure GetDiscount(): Decimal
    begin
        exit(10);
    end;

    procedure SendEmail()
    begin

    end;
}