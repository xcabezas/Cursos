codeunit 50140 "IUSUP Courses Test"
{
    Subtype = Test;

    [Test]
    procedure Test001()
    begin

    end;

    [Test]
    procedure Test002()
    begin
        Error('Un error del test');
    end;

    [Test]
    procedure Test003()
    var
        IUSUPMin: Codeunit IUSUPMin;
        Value1: Decimal;
        Value2: Decimal;
        Result: Decimal;

    begin

        Value1 := 1;
        Value2 := 2;
        Result := IUSUPMin.GetMin(Value1, Value2);

        if Result <> Value1 then
            Error('El resultado no es correcto');
    end;
}