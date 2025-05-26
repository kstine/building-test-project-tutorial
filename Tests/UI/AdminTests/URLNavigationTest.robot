*** Settings ***
Resource            Resources/REST/RestfulBookerRestApi.resource
Resource            Resources/UI/Admin/Branding.resource
Resource            Resources/UI/Admin/Login.resource
Resource            Resources/UI/Admin/Messages.resource
Resource            Resources/UI/Admin/Report.resource
Resource            Resources/UI/Admin/Rooms.resource
Resource            Resources/UI/Common/Navigation.resource

Suite Setup         Suite Setup Keywords
Suite Teardown      Suite Teardown Keywords
Test Setup          New Web Browser    add_banner_cookie=${FALSE}
Test Teardown       Close Browser

Test Tags           ui-api    url-navigation    admin


*** Variables ***
${UI_TEST_ALIAS}    ui-test-alias


*** Test Cases ***
URL Navigation Test
    Click Let Me Hack Button
    Verify Banner Cookie

Admin URL Navigation Test
    Click Let Me Hack Button
    Navigate To Admin Login Page
    Wait For Login Header To Load

Room URL Navigation Test
    [Setup]    Test Setup With Token Cookie
    Navigate To Rooms By URL
    Verify Room Header Row Columns

Report URL Navigation Test
    [Setup]    Test Setup With Token Cookie
    Navigate To Reports By URL
    Wait For Report Calendar To Be Visible

Branding URL Navigation Test
    [Setup]    Test Setup With Token Cookie
    Navigate To Branding By URL
    Wait For Branding Form To Be Visible

Message URL Navigation Test
    [Setup]    Test Setup With Token Cookie
    Navigate To Messages By URL
    Wait For Messages Container To Be Visible


*** Keywords ***
Suite Setup Keywords
    Create RB Session    ${UI_TEST_ALIAS}

Suite Teardown Keywords
    Delete All Sessions
    Close All Browsers

Test Setup With Token Cookie
    ${response}    Post On Session To Authentication Endpoint    ${UI_TEST_ALIAS}    &{ADMIN_CREDENTIALS}
    ${token_cookie}    Get Token Cookie From Response    ${response}
    New Web Browser
    Add Token Cookie    ${token_cookie}
