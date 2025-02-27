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
    Click Report Navbar Link
    Click Branding Navbar Link
    Click Notifications Navbar Link
    Click Front Page Navbar Link
    Go Back
    Wait Until Location Is
    ...        ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_URL_EXT.ADMIN}/${RB_URL_EXT.MESSAGES}
    Click Logout Navbar Link
    [Teardown]    Close All Browsers
