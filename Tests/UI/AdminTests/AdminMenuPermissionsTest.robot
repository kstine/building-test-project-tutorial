*** Settings ***
Documentation       Example test file.

Resource            Resources/UI/Admin/Login.resource
Resource            Resources/UI/Admin/Navbar.resource

Test Tags           ui-api    menu-tour    admin


*** Test Cases ***
Verify Admin Menu Permissions
    [Tags]    happy-path
    [Setup]    New Web Browser
    Navigate To Admin Login Page
    Enter Username    ${ADMIN_CREDENTIALS}[username]
    Enter Password    ${ADMIN_CREDENTIALS}[password]
    Click Login Button
    Wait For Booking Management To Load
    Click Rooms Navbar Link
    Wait For Rooms Location
    Click Report Navbar Link
    Wait For Report Location
    Click Branding Navbar Link
    Wait For Branding Location
    Click Notifications Navbar Link
    Wait For Messages Location
    Click Front Page Navbar Link
    Go Back
    Wait For Messages Location
    Click Logout Navbar Link
    Wait For Admin Location
    [Teardown]    Close All Browsers
