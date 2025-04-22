permissionset 50100 "IUSUP CourseSUPER"
{
    Caption = 'Permisions', Comment = 'ESP="Permisos"';
    Assignable = true;
    Permissions =
        tabledata "IUSUP Course" = RIMD,
        tabledata "IUSUP Course Edition" = RIMD,
        tabledata "IUSUP Course Setup" = RIMD,
        page "IUSUP Course Card" = X,
        page "IUSUP Course Editions" = X,
        page "IUSUP Course Editions Factbox" = X,
        page "IUSUP Course List" = X,
        page "IUSUP Courses Setup" = X;
}