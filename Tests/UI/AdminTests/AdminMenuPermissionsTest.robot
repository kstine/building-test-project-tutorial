*** Settings ***
Documentation       Example test file.

Library             SeleniumLibrary

Test Tags           ui-api    menu-tour    admin

*** Test Cases ***
Verify Admin Menu Permissions
    [Tags]    happy-path
    # Open Browser    url=https://automationintesting.online    browser=Firefox
    # Add Cookie    name=banner    value=true    domain=automationintesting.online
    Open Browser    url=http://tomtebook-pro.local:8080/    browser=Chrome
    Add Cookie    name=banner    value=true    domain=tomtebook-pro.local
    Reload Page
    Go To    http://tomtebook-pro.local:8080/#/admin
    Wait Until Page Contains Element    id=username
    Input Text    id=username    admin
    Input Text    id=password    password
    Click Button    Login
    Wait Until Page Contains    B&B Booking Management
    Click Link    \#/admin/
    Wait Until Location Is    http://tomtebook-pro.local:8080/#/admin/
    Click Link    \#/admin/report
    Wait Until Location Is    http://tomtebook-pro.local:8080/#/admin/report
    Click Link    \#/admin/branding
    Wait Until Location Is    http://tomtebook-pro.local:8080/#/admin/branding
    Click Link    \#/admin/messages
    Wait Until Location Is    http://tomtebook-pro.local:8080/#/admin/messages
    Click Link    /
    Wait Until Location Is    http://tomtebook-pro.local:8080/
    Go Back
    Wait Until Location Is    http://tomtebook-pro.local:8080/#/admin/messages
    Click Link    \#/admin
    Close All Browsers