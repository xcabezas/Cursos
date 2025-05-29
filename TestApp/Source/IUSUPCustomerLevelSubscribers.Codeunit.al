codeunit 50143 "IUSUPCustomerLevelSubscribers" implements IUSUPCustomerLevel
{
    procedure GetDiscount(): Decimal
    begin
        exit(30);
    end;

    procedure SendEmail()
    begin

    end;
}