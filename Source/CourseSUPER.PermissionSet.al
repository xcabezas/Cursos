permissionset 50100 "CourseSUPER"
{
    CaptionML = ENU = 'Permisions', ESP = 'Permisos';
    Assignable = true;
    Permissions =
        table Course = X,
        table "Course Edition" = X,
        table "Course Setup" = X,
        page "Course Card" = X,
        page "Course Editions" = X,
        page "Course Editions Factbox" = X,
        page "Course List" = X,
        page "Courses Setup" = X;
}