*** Settings ***
Documentation       Example test file.

Resource            Resources/UI/Admin/AdminNavbar.resource
Resource            Resources/UI/Admin/Login.resource
Resource            Resources/UI/Common/Navigation.resource
Resource            Resources/UI/Customer/CustomerNavbar.resource

Test Tags           ui-api    menu-tour    admin


*** Test Cases ***
Verify Admin Menu Permissions
    [Tags]    happy-path
    [Setup]    New Web Browser
    Click "Admin" Navbar Link
    Enter Username    ${ADMIN_CREDENTIALS}[username]
    Enter Password    ${ADMIN_CREDENTIALS}[password]
    Click Login Button
    Wait For Booking Management To Load
    Click "Rooms" Admin Navbar Link
    Click "Report" Admin Navbar Link
    Click "Branding" Admin Navbar Link
    Click "Messages" Admin Navbar Link
    Click Front Page Admin Navbar Link
    Wait For Front Page To Load
    Go Back
    Wait For "Messages" Admin Location
    Click Logout Admin Navbar Link
    Wait For Front Page To Load
    [Teardown]    Close All Browsers
