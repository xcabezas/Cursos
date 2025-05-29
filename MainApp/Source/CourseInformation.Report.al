report 50101 "IUSUP Course Information"
{
    Caption = 'Course Information', comment = 'ESP="Información cursos"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = Excel;

    dataset
    {
        dataitem(Course; "IUSUP Course")
        {
            // PrintOnlyIfDetail = true;
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl) { }
            column(Customer___ListCaption; Customer___ListCaptionLbl) { }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName()) { }
            column(CourseNo; "No.") { IncludeCaption = true; }
            column(CourseName; Name) { IncludeCaption = true; }
            column(Price; Price) { IncludeCaption = true; }

            dataitem("CLIP Course Edition"; "IUSUP Course Edition")
            {
                DataItemLinkReference = Course;
                DataItemLink = "Course No." = field("No.");
                DataItemTableView = sorting("Course No.", Edition);

                column(CourseEdition; Edition)
                {
                    IncludeCaption = true;
                }
                column(CourseEditionMaxStudents; "Max. Students") { IncludeCaption = true; }
                column(CourseEditionSalesQty; "Sales (Qty.)") { IncludeCaption = true; }
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options', comment = 'ESP="Opciones"';
                    // field(Name; SourceExpression)
                    // {

                    // }
                }
            }
        }
    }

    rendering
    {
        layout(RDLC)
        {
            Type = RDLC;
            LayoutFile = 'Source/CourseInformation.rdl';
        }
        layout(Excel)
        {
            Type = Excel;
            LayoutFile = 'Source/CourseInformation.xlsx';
        }
        layout(Word)
        {
            Type = Word;
            LayoutFile = 'Source/CourseInformation.docx';
        }
    }

    var
        CurrReport_PAGENOCaptionLbl: Label 'Page', Comment = 'ESP="Pág."';
        Customer___ListCaptionLbl: Label 'Course Information', Comment = 'ESP="Información cursos"';
}