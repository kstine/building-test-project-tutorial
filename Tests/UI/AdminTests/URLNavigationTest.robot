*** Settings ***
Library     Collections
Library     String
Library     RequestsLibrary
Library     SeleniumLibrary
Test Tags   ui-api    url-navigation    admin


*** Test Cases ***
URL Navigation Test
    Open Browser    url=https://automationintesting.online    browser=Chrome
    Click Button    Let me hack!
    ${cookies}    Get Cookies
    Should Be Equal    ${cookies}    banner=true
    Close All Browsers

Admin URL Navigation Test
    Open Browser    url=https://automationintesting.online/#/admin    browser=Chrome
    Click Button    Let me hack!
    Wait Until Page Contains Element    css=h2[data-testid="login-header"]
    Close All Browsers

Message URL Navigation Test
    VAR    &{body}    username=admin    password=password
    ${response}    POST    url=https://automationintesting.online/auth/login    json=${body}
    ${beer}    Get From Dictionary    ${response.headers}    Set-Cookie
    ${ale}    Split String    ${beer}    separator=;
    ${token}    Split String    ${ale}[0]    separator==
    Open Browser    url=https://automationintesting.online/#/admin/messages    browser=Chrome
    Add Cookie    name=banner    value=true    domain=automationintesting.online
    Add Cookie    name=token    value=${token}[1]    domain=automationintesting.online
    Get Location
    Wait Until Page Contains Element    css=div.messages
    Close All Browsers

Messages URL Navigation Test
    VAR    &{body}    username=admin    password=password
    ${response}    POST    url=https://automationintesting.online/auth/login    json=${body}
    ${beer}    Get From Dictionary    ${response.headers}    Set-Cookie
    ${ale}    Split String    ${beer}    separator=;
    ${token}    Split String    ${ale}[0]    separator==
    Open Browser    url=https://automationintesting.online/#/admin/messages    browser=Chrome
    Add Cookie    name=banner    value=true    domain=automationintesting.online
    Add Cookie    name=token    value=${token}[1]    domain=automationintesting.online
    Get Location
    Wait Until Page Contains Element    css=div.messages
    Close All Browsers

Report URL Navigation Test
    VAR    &{body}    username=admin    password=password
    ${response}    POST    url=https://automationintesting.online/auth/login    json=${body}
    ${beer}    Get From Dictionary    ${response.headers}    Set-Cookie
    ${ale}    Split String    ${beer}    separator=;
    ${token}    Split String    ${ale}[0]    separator==
    Open Browser    url=https://automationintesting.online/#/admin/report    browser=Chrome
    Add Cookie    name=banner    value=true    domain=automationintesting.online
    Add Cookie    name=token    value=${token}[1]    domain=automationintesting.online
    Get Location
    Wait Until Page Contains Element    css=div.rbc-calendar
    Close All Browsers

Branding URL Navigation Test
    VAR    &{body}    username=admin    password=password
    ${response}    POST    url=https://automationintesting.online/auth/login    json=${body}
    ${beer}    Get From Dictionary    ${response.headers}    Set-Cookie
    ${ale}    Split String    ${beer}    separator=;
    ${token}    Split String    ${ale}[0]    separator==
    Open Browser    url=https://automationintesting.online/#/admin    browser=Chrome
    Add Cookie    name=banner    value=true    domain=automationintesting.online
    Add Cookie    name=token    value=${token}[1]    domain=automationintesting.online
    Get Location
    Goto    https://automationintesting.online/#/admin/branding
    Wait Until Page Contains Element    css=div.branding-form
    Close All Browsers
