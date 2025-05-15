report 50101 "IUSUP Course Information"
{
    Caption = 'Course Information', comment = 'ESP="Información del curso"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = RDLC;

    dataset
    {
        dataitem(Course; "IUSUP Course")
        {
            column(CourseNo; "No.")
            {

            }
            column(CourseName; Name)
            {

            }
            column(CoursePrice; Price)
            {

            }
            dataitem("IUSUP Course Edition"; "IUSUP Course Edition")
            {
                DataItemLinkReference = Course;
                dataitemlink = "Course No." = field("No.");
                column(CourseEdition; Edition)
                {

                }
                column(CourseEditionSales__Qty__; "sales (Qty.)")
                {

                }
                column(CourseEditionMax_students; "Max. students")
                {

                }
            }
        }

    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options', comment = 'ESP="Opciones"';

                }
            }
        }

    }

    rendering
    {
        layout(RDLC)
        {
            Type = RDLC;
            LayoutFile = 'Source/MiReport.rdl';
        }
    }


}