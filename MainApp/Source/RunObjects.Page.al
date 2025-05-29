page 50107 "IUSUP Run Objects"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;

    actions
    {
        area(Processing)
        {
            action(ExportSalesOrders)
            {
                image = Export;
                RunObject = xmlport "IUSUP Export Sales Orders";
            }
        }
    }
}