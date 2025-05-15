codeunit 50140 "IUSUP Courses Test"
{
    Subtype = Test;
    TestPermissions = Disabled;


    [Test]
    procedure Test001()
    begin

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

    [Test]
    procedure SelectingACourseOnASAlesLine();
    var
        Course: Record "IUSUP Course";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
        LibraryCourse: Codeunit "IUSUP Library - Course";
    begin
        // [Scenario] al seleccionar un curso en una línea de venta, el sistema rellena la información relacionada

        // [Given] Un curso con descripción, precio y grupos contables
        //         Un documento de venta
        Course := LibraryCourse.CreateCourse();


        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Invoice, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);
        // [When] seleccionamos el curso en el documento de venta 

        SalesLine.Validate(Type, "Sales Line Type"::"IUSUP Course");
        SalesLine.Validate("No.", Course."No.");

        // [Then] la linea de venta tiene la Descripción, precio y grupos contables especifícados en el curso 
        LibraryAssert.AreEqual(Course.Name, SalesLine.Description, 'La descripcion no es correcta');
        LibraryAssert.AreEqual(Course.Price, SalesLine."Unit Price", 'El precio no es correcta');
        LibraryAssert.AreEqual(Course."Gen. Prod. Posting Group", SalesLine."Gen. Prod. Posting Group", 'El grupo no es correcta');
        LibraryAssert.AreEqual(Course."VAT Prod. Posting Group", SalesLine."VAT Prod. Posting Group", 'El IVA no es correcta');
    end;

    [Test]
    procedure CourseSalesPosting()
    var
        Course: Record "IUSUP Course";
        CourseEdition: Record "IUSUP Course Edition";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesShipmentLine: Record "Sales Shipment Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
        LibraryCourse: Codeunit "IUSUP Library - Course";
        DocumentNo: Code[20];
    begin
        // [Scenario] Al registrar un pedido de venta para un curso y edición, la información de la edición se guarda en los documentos registrados (albarán y factura)

        // [Given] Un curso
        //         Una edición
        //         Un pedido de venta para el curso y edición
        Course := LibraryCourse.CreateCourse();
        CourseEdition := LibraryCourse.CreateEdition(Course);
        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLine(SalesLine, SalesHeader, "Sales Line Type"::"IUSUP Course", Course."No.", 1);
        SalesLine.Validate("IUSUP Course Edition", CourseEdition.Edition);
        SalesLine.Modify(true);

        // [When] Registremos el albarán
        DocumentNo := LibrarySales.PostSalesDocument(SalesHeader, true, false);
        // [Then] La edición es correcta en el albarán
        SalesShipmentLine.Get(DocumentNo, SalesLine."Line No.");
        LibraryAssert.AreEqual(SalesLine."IUSUP Course Edition", SalesShipmentLine."IUSUP Course Edition", 'La edición no es correcta en el albarán');

        // [When] Registremos la factura
        DocumentNo := LibrarySales.PostSalesDocument(SalesHeader, false, true);
        // [Then] La edición es correcta en la factura
        SalesInvoiceLine.Get(DocumentNo, SalesLine."Line No.");
        LibraryAssert.AreEqual(SalesLine."IUSUP Course Edition", SalesInvoiceLine."IUSUP Course Edition", 'La edición no es correcta en la factura');
    end;

    [Test]
    procedure CourseSalesPostingLedgerEntry()
    var
        Course: Record "IUSUP Course";
        CourseEdition: Record "IUSUP Course Edition";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        CourseLedgerEntry: Record "IUSUP Course Ledger Entry";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
        LibraryCourse: Codeunit "IUSUP Library - Course";
        DocumentNo: Code[20];
    begin
        // [Scenario] Al registrar un documento de venta (factura o abono), el sistema deba crear un movimiento de curso

        // [Given] Un curso
        //         Una edición
        //         Un pedido de venta para el curso y edición
        Course := LibraryCourse.CreateCourse();
        CourseEdition := LibraryCourse.CreateEdition(Course);
        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLine(SalesLine, SalesHeader, "Sales Line Type"::"IUSUP Course", Course."No.", 1);
        SalesLine.Validate("IUSUP Course Edition", CourseEdition.Edition);
        SalesLine.Modify(true);

        // [When] Registremos el albarán
        DocumentNo := LibrarySales.PostSalesDocument(SalesHeader, true, false);
        // [Then] No se ha creado movimiento de curso
        CourseLedgerEntry.SetRange("Document No.", DocumentNo);
        LibraryAssert.AreEqual(0, CourseLedgerEntry.Count(), 'El registro del albarán no debe crear movimientos de curso');

        // [When] Registremos la factura
        DocumentNo := LibrarySales.PostSalesDocument(SalesHeader, false, true);
        // [Then] Se ha creado el movimiento de curso
        CourseLedgerEntry.SetRange("Document No.", DocumentNo);
        LibraryAssert.AreEqual(1, CourseLedgerEntry.Count(), 'El registro de la factura tiene que crear movimiento de curso');

        CourseLedgerEntry.FindFirst();
        LibraryAssert.AreEqual(SalesHeader."Posting Date", CourseLedgerEntry."Posting Date", 'La fecha registro no es correcta');
        LibraryAssert.AreEqual(SalesLine."No.", CourseLedgerEntry."Course No.", 'El Nº curso no es correcto');
        LibraryAssert.AreEqual(SalesLine."IUSUP Course Edition", CourseLedgerEntry."Course Edition", 'La edición no es correcta');
        LibraryAssert.AreEqual(SalesLine.Description, CourseLedgerEntry.Description, 'La descripción no es correcta');
        LibraryAssert.AreEqual(SalesLine.Quantity, CourseLedgerEntry.Quantity, 'La cantidad no es correcta');
        LibraryAssert.AreEqual(SalesLine."Unit Price", CourseLedgerEntry."Unit Price", 'El precio no es correcto');
        LibraryAssert.AreEqual(SalesLine."Line Amount", CourseLedgerEntry."Total Price", 'El precio total no es correcto');
        LibraryAssert.AreEqual(SalesLine."Return Reason Code", CourseLedgerEntry."Reason Code", 'El motivo de devolución no es correcto');
        LibraryAssert.AreEqual(SalesLine."Gen. Bus. Posting Group", CourseLedgerEntry."Gen. Bus. Posting Group", 'El grupo contable negocio no es correcto');
        LibraryAssert.AreEqual(SalesLine."Gen. Prod. Posting Group", CourseLedgerEntry."Gen. Prod. Posting Group", 'El grupo contable producto no es correcto');
        LibraryAssert.AreEqual(SalesHeader."Document Date", CourseLedgerEntry."Document Date", 'La fecha documento no es correcta');
        LibraryAssert.AreEqual(SalesHeader."External Document No.", CourseLedgerEntry."External Document No.", 'El Nº documento externo no es correcto');
        LibraryAssert.AreEqual(SalesHeader."Sell-to Customer No.", CourseLedgerEntry."Customer No.", 'El cliente no es correcto');
    end;

    [Test]
    [HandlerFunctions('MessageMaxStudentExceeded')]

    procedure CheckCourseEdition()
    var
        Course: Record "IUSUP Course";
        CourseEdition: Record "IUSUP Course Edition";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesShipmentLine: Record "Sales Shipment Line";
        CourseLedgerEntry: Record "IUSUP Course Ledger Entry";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
        LibraryCourse: Codeunit "IUSUP Library - Course";

    begin
        // [Scenario] Al crear un curso, se crea una edición por defecto

        // [Given] Un curso
        Course := LibraryCourse.CreateCourse();
        CourseEdition := LibraryCourse.CreateEdition(Course);

        // [When] Creamos la edición por defecto
        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Invoice, '');
        LibrarySales.CreateSalesLine(SalesLine, SalesHeader, "Sales Line Type"::"IUSUP Course", Course."No.", 2);
        SalesLine.Validate("IUSUP Course Edition", CourseEdition.Edition);
        SalesLine.Modify(true);
        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLine(SalesLine, SalesHeader, "Sales Line Type"::"IUSUP Course", Course."No.", 3);
        SalesLine.Validate("IUSUP Course Edition", CourseEdition.Edition);
        SalesLine.Modify(true);
        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLine(SalesLine, SalesHeader, "Sales Line Type"::"IUSUP Course", Course."No.", 4);
        SalesLine.Validate("IUSUP Course Edition", CourseEdition.Edition);
        SalesLine.Modify(true);
        LibrarySales.PostSalesDocument(SalesHeader, true, true);


        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Invoice, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);
        SalesLine.Validate(Type, "Sales Line Type"::"IUSUP Course");
        SalesLine.Validate("No.", Course."No.");

        SalesLine.Validate(Quantity, 12);

        // [Then] La edición es correcta
        SalesLine.Validate("IUSUP Course Edition", CourseEdition.Edition);
    end;

    [MessageHandler]
    procedure MessageMaxStudentExceeded(Message: Text[1024])
    var
        LibraryAssert: Codeunit "Library Assert";
    begin
        LibraryAssert.IsTrue(Message.Contains('Con las ventas previas'), 'El mensaje no es correcto');
    end;
}