*** Settings ***
Resource        Resources/REST/Authentication.resource
Resource        Resources/UI/Admin/Branding.resource
Resource        Resources/UI/Admin/Login.resource
Resource        Resources/UI/Admin/Messages.resource
Resource        Resources/UI/Admin/Report.resource
Resource        Resources/UI/Admin/Rooms.resource

Test Tags       ui-api    url-navigation    admin


*** Test Cases ***
URL Navigation Test
    [Setup]    New Web Browser    add_banner_cookie=${FALSE}
    Click Let Me Hack Button
    Verify Banner Cookie
    [Teardown]    Close All Browsers

Admin URL Navigation Test
    [Setup]    New Web Browser    add_banner_cookie=${FALSE}
    Click Let Me Hack Button
    Navigate To Admin Login Page
    Wait For Login Header To Load
    [Teardown]    Close All Browsers

Room URL Navigation Test
    ${response}    Post Request To Authentication Endpoint    &{ADMIN_CREDENTIALS}
    ${token_cookie}    Get Token Cookie From Response    ${response}
    New Web Browser
    Add Token Cookie    ${token_cookie}
    Navigate To Rooms By URL
    Verify Room Header Row Columns
    [Teardown]    Close All Browsers

Report URL Navigation Test
    ${response}    Post Request To Authentication Endpoint    &{ADMIN_CREDENTIALS}
    ${token_cookie}    Get Token Cookie From Response    ${response}
    New Web Browser
    Add Token Cookie    ${token_cookie}
    Navigate To Reports By URL
    Wait For Report Calendar To Be Visible
    [Teardown]    Close All Browsers

Branding URL Navigation Test
    ${response}    Post Request To Authentication Endpoint    &{ADMIN_CREDENTIALS}
    ${token_cookie}    Get Token Cookie From Response    ${response}
    New Web Browser
    Add Token Cookie    ${token_cookie}
    Navigate To Branding By URL
    Wait For Branding Form To Be Visible
    [Teardown]    Close All Browsers

Message URL Navigation Test
    ${response}    Post Request To Authentication Endpoint    &{ADMIN_CREDENTIALS}
    ${token_cookie}    Get Token Cookie From Response    ${response}
    New Web Browser
    Add Token Cookie    ${token_cookie}
    Navigate To Messages By URL
    Wait For Messages Container To Be Visible
    [Teardown]    Close All Browsers
