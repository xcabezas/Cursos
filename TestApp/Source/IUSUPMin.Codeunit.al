codeunit 50141 IUSUPMin
{
    procedure GetMin(v1: Decimal; v2: Decimal): Decimal;

    begin
        if v1 < v2 then
            exit(v1)
    end;
}