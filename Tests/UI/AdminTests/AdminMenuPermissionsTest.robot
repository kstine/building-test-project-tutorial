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
    Wait Until Element Is Visible    xpath=//li/a[contains(@href, "admin")][text()="Rooms"]
    Click Element    xpath=//li/a[contains(@href, "admin")][text()="Rooms"]
    Wait Until Location Is    http://tomtebook-pro.local:8080/#/admin/
    Wait Until Element Is Visible    id=reportLink
    Click Element    id=reportLink
    Wait Until Location Is    http://tomtebook-pro.local:8080/#/admin/report
    Wait Until Element Is Visible    id=brandingLink
    Click Element    id=brandingLink
    Wait Until Location Is    http://tomtebook-pro.local:8080/#/admin/branding
    Wait Until Element Is Visible    css=a.nav-link[href="#/admin/messages"]
    Click Element    css=a.nav-link[href="#/admin/messages"]
    Wait Until Location Is    http://tomtebook-pro.local:8080/#/admin/messages
    Wait Until Element Is Visible    id=frontPageLink
    Click Element    id=frontPageLink
    Wait Until Location Is    http://tomtebook-pro.local:8080/
    Go Back
    Wait Until Location Is    http://tomtebook-pro.local:8080/#/admin/messages
    Wait Until Element Is Visible    css=a.nav-link[href="#/admin"]
    Click Element    css=a.nav-link[href="#/admin"]
    Close All Browsers