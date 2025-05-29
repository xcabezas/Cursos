codeunit 50105 "IUSUPGold Customer Level" implements IUSUPCustomerLevel
{
    procedure GetDiscount(): Decimal
    begin
        exit(15);
    end;

    procedure SendEmail()
    begin

    end;
}