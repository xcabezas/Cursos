xmlport 50101 "IUSUP Import Course"
{
    Format = VariableText;
    FieldSeparator = ';';
    FieldDelimiter = '"';
    Direction = Import;
    FormatEvaluate = Xml;

    schema
    {
        textelement(Root)
        {
            tableelement(Course; "IUSUP Course")
            {
                // AutoReplace = true;
                AutoUpdate = true;
                // UseTemporary = true;

                fieldelement(CourseNo; Course."No.") { }
                fieldelement(CourseName; Course."Name") { }
                fieldelement(CoursePrice; Course.Price) { }

                trigger OnBeforeInsertRecord()
                begin
                    DoExtraCalculations(Course);
                    // Course.Insert();
                end;

                trigger OnBeforeModifyRecord()
                begin
                    DoExtraCalculations(Course);
                    // Course.Modify();
                end;
            }
        }
    }

    local procedure DoExtraCalculations(var Course: Record "IUSUP Course")
    begin
        Course.Price := Round(Course.Price / 100, 1);
    end;
}