enum 50101 "IUSUP Customer Level" implements IUSUPCustomerLevel
{
    Extensible = true;

    value(0; " ")
    {
        Implementation = IUSUPCustomerLevel = "IUSUPBlank Customer Level";
    }
    value(1; "Bronze")
    {
        Implementation = IUSUPCustomerLevel = "IUSUPBronze Customer Level";
    }
    value(2; "Silver")
    {
        Implementation = IUSUPCustomerLevel = "IUSUPSilver Customer Level";
    }
    value(3; "Gold")
    {
        Implementation = IUSUPCustomerLevel = "IUSUPGold Customer Level";
    }
}