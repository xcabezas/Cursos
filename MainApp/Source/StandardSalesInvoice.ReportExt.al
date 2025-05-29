reportextension 50100 "IUSUP Standard Sales - Invoice" extends "Standard Sales - Invoice"
{
    dataset
    {
        add(Line)
        {
            column(IUSUP_Course_Edition; "IUSUP Course Edition")
            {
                IncludeCaption = true;
            }
        }
    }

    requestpage
    {
        layout
        {
            modify(DisplayShipmentInformation)
            {
                Visible = false;
            }
        }
    }

    rendering
    {
        layout(IUSUPNuevoRDLCConEdiciones)
        {
            Type = RDLC;
            LayoutFile = './source/StandardSalesInvoice.rdl';
        }
    }
}