permissionset 50100 "CourseSUPER"
{
    Caption = 'Permisions', Comment = 'ESP="Permisos"';
    Assignable = true;
    Permissions =
        tabledata Course = RIMD,
        tabledata "Course Edition" = RIMD,
        tabledata "Course Setup" = RIMD,
        page "Course Card" = X,
        page "Course Editions" = X,
        page "Course Editions Factbox" = X,
        page "Course List" = X,
        page "Courses Setup" = X;
}