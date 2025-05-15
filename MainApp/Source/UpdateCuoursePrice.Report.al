report 50100 "IUSUP Update Cuourse Price"
{
    Caption = 'Update Course Price', comment = 'ESP="Actualizar precio curso"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Course; "IUSUP Course")
        {
            RequestFilterFields = "No.", "Name", Price;
            trigger OnPreDataItem()

            begin
                //Codigo que se ejecuta antes de que empiece el bucle
                Message('Iniciando el bucle');
            end;

            trigger OnAfterGetRecord()

            begin
                //Codigo que se ejecuta en cada una de las iteraciones del bucle
                Message('Iterando el bucle ' + Course."No.");
                Course.Validate(Price, Course.Price * (Percentaje / 100));
                Course.Modify();

            end;

            trigger OnPostDataItem()

            begin
                //Codigo que se ejecuta despues de que termine el bucle
                Message('Finalizando el bucle');
            end;
        }

    }
    requestpage
    {

        layout
        {

            area(Content)
            {
                group(GroupName)
                {
                    Caption = 'Options', comment = 'ESP="Opciones"';
                    field(PercentajeControl; Percentaje)
                    {
                        Caption = 'Percentaje', comment = 'ESP="Porcentaje"';
                        ToolTip = 'Porcentaje de aumento del precio';
                        ApplicationArea = All;
                        DecimalPlaces = 2;
                    }
                }
            }
        }
        trigger OnOpenPage()

        begin
            Percentaje := 100;
        end;

    }
    trigger OnPreReport()

    begin
        if Percentaje = 0 then
            Error('El porcentaje no puede ser 0');
    end;

    var
        Percentaje: Decimal;
}

