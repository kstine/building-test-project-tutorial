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
    Open Browser    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]    browser=Chrome
    Add Cookie    &{BANNER_COOKIE}
    Reload Page
    Go To    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}
    Wait Until Page Contains Element    ${LOGIN_USERNAME_INPUT}
    Input Text    ${LOGIN_USERNAME_INPUT}    ${ADMIN_CREDENTIALS}[username]
    Input Text    ${LOGIN_PASSWORD_INPUT}    ${ADMIN_CREDENTIALS}[password]
    Click Button    ${LOGIN_BUTTON_TEXT}
    Wait Until Page Contains    ${BOOKING_MGT_TITLE}
    Wait Until Element Is Visible    ${ADMIN_NAVBAR_ROOMS_LINK}
    Click Element    ${ADMIN_NAVBAR_ROOMS_LINK}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/
    Click Element    ${ADMIN_NAVBAR_REPORT_LINK}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_REPORT_EXT}
    Click Element    ${ADMIN_NAVBAR_BRANDING_LINK}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_BRANDING_EXT}
    Click Element    ${ADMIN_NAVBAR_NOTIFICATIONS_LINK}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_MESSAGES_EXT}
    Click Element    ${ADMIN_NAVBAR_FRONT_PAGE_LINK}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/
    Go Back
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_MESSAGES_EXT}
    Wait Until Element Is Visible    ${ADMIN_NAVBAR_LOGOUT_LINK}
    Click Element    ${ADMIN_NAVBAR_LOGOUT_LINK}
    Close All Browsers
