permissionset 50100 "IUSUP CourseSUPER"
{
    Caption = 'All for Courses app', Comment = 'ESP="Todos los permisos para los cursos"';
    Assignable = true;
    Permissions = tabledata "IUSUP Course" = RIMD,
        tabledata "IUSUP Course Edition" = RIMD,
        tabledata "IUSUP Course Setup" = RMID,
        table "IUSUP Course" = X,
        table "IUSUP Course Setup" = X,
        table "IUSUP Course Edition" = X,
        page "IUSUP Course Card" = X,
        page "IUSUP Course Editions" = X,
        page "IUSUP Course Editions Factbox" = X,
        page "IUSUP Course List" = X,
        page "IUSUP Courses Setup" = X,
        table "IUSUP Course Ledger Entry" = X,
        tabledata "IUSUP Course Ledger Entry" = RMID,
        codeunit "IUSUPCourse - Sales Management" = X,
        table "IUSUP Course Journal Line" = X,
        tabledata "IUSUP Course Journal Line" = RMID,
        page "IUSUP Course Ledger Entries" = X;
}