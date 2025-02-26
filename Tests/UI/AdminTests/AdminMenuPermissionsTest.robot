*** Settings ***
Documentation       Example test file.

Library             SeleniumLibrary

Test Tags           ui-api    menu-tour    admin


*** Variables ***
&{PRODUCTION_URL_DATA}
...                                     DOMAIN=automationintesting.online
...                                     URL=https://automationintesting.online
&{TEST_URL_DATA}
...                                     DOMAIN=tomtebook-pro.local
...                                     URL=http://tomtebook-pro.local:8080
&{BOOKING_URL_DATA}                     PROD=${PRODUCTION_URL_DATA}    TEST=${TEST_URL_DATA}
${BOOKING_ENVIRONMENT}                  PROD
&{BANNER_COOKIE}
...                                     name=banner
...                                     value=true
...                                     domain=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][DOMAIN]
${RB_ADMIN_EXT}                         \#/admin
${RB_REPORT_EXT}                        report
${RB_BRANDING_EXT}                      branding
${RB_MESSAGES_EXT}                      messages
${LOGIN_USERNAME_INPUT}                 id=username
${LOGIN_PASSWORD_INPUT}                 id=password
${LOGIN_BUTTON}                         id=doLogin
${LOGIN_BUTTON_TEXT}                    Login
&{ADMIN_CREDENTIALS}                    username=admin    password=password
${BOOKING_MGT_TITLE}                    B&B Booking Management
${ADMIN_NAVBAR_ROOMS_LINK}              xpath://li/a[contains(@href, "admin")][text()="Rooms"]
${ADMIN_NAVBAR_REPORT_LINK}             id=reportLink
${ADMIN_NAVBAR_BRANDING_LINK}           id=brandingLink
${ADMIN_NAVBAR_NOTIFICATIONS_LINK}      css=a.nav-link[href="#/admin/messages"]
${ADMIN_NAVBAR_FRONT_PAGE_LINK}         id=frontPageLink
${ADMIN_NAVBAR_LOGOUT_LINK}             css=a.nav-link[href="#/admin"]


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
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_MESSAGES_EXT}
    Click Logout Navbar Link
    [Teardown]    Close All Browsers


*** Keywords ***
New Web Browser
    [Arguments]    ${add_banner_cookie}=${TRUE}
    Open Browser    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]    browser=Chrome
    IF    ${add_banner_cookie}
        Add Cookie    &{BANNER_COOKIE}
        Reload Page
    END

Navigate To Admin Login Page
    Go To    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}

Enter Username
    [Arguments]    ${username}
    Wait Until Page Contains Element    ${LOGIN_USERNAME_INPUT}
    Input Text    ${LOGIN_USERNAME_INPUT}    ${username}

Enter Password
    [Arguments]    ${password}
    Wait Until Page Contains Element    ${LOGIN_PASSWORD_INPUT}
    Input Password    ${LOGIN_PASSWORD_INPUT}    ${password}

Click Login Button
    Wait Until Element Is Enabled    ${LOGIN_BUTTON}
    Click Button    ${LOGIN_BUTTON_TEXT}

Wait For Booking Management To Load
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}
    Wait Until Page Contains    ${BOOKING_MGT_TITLE}

Click Rooms Navbar Link
    Wait Until Element Is Visible    ${ADMIN_NAVBAR_ROOMS_LINK}
    Click Element    ${ADMIN_NAVBAR_ROOMS_LINK}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/

Click Report Navbar Link
    Wait Until Element Is Visible    ${ADMIN_NAVBAR_REPORT_LINK}
    Click Element    ${ADMIN_NAVBAR_REPORT_LINK}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_REPORT_EXT}

Click Branding Navbar Link
    Wait Until Element Is Visible    ${ADMIN_NAVBAR_BRANDING_LINK}
    Click Element    ${ADMIN_NAVBAR_BRANDING_LINK}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_BRANDING_EXT}

Click Notifications Navbar Link
    Wait Until Element Is Visible    ${ADMIN_NAVBAR_NOTIFICATIONS_LINK}
    Click Element    ${ADMIN_NAVBAR_NOTIFICATIONS_LINK}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_MESSAGES_EXT}

Click Front Page Navbar Link
    Wait Until Element Is Visible    ${ADMIN_NAVBAR_FRONT_PAGE_LINK}
    Click Element    ${ADMIN_NAVBAR_FRONT_PAGE_LINK}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/

Click Logout Navbar Link
    Wait Until Element Is Visible    ${ADMIN_NAVBAR_LOGOUT_LINK}
    Click Element    ${ADMIN_NAVBAR_LOGOUT_LINK}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}
