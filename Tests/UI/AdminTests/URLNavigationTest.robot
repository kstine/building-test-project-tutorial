*** Settings ***
Library         Collections
Library         String
Library         RequestsLibrary
Library         SeleniumLibrary

Test Tags       ui-api    url-navigation    admin


*** Variables ***
&{PRODUCTION_URL_DATA}
...                         DOMAIN=automationintesting.online
...                         URL=https://automationintesting.online
&{TEST_URL_DATA}
...                         DOMAIN=tomtebook-pro.local
...                         URL=http://tomtebook-pro.local:8080
&{BOOKING_URL_DATA}         PROD=${PRODUCTION_URL_DATA}    TEST=${TEST_URL_DATA}
${BOOKING_ENVIRONMENT}      PROD
&{BANNER_COOKIE}
...                         name=banner
...                         value=true
...                         domain=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][DOMAIN]
${RB_ADMIN_EXT}             \#/admin
${RB_REPORT_EXT}            report
${RB_BRANDING_EXT}          branding
${RB_MESSAGES_EXT}          messages
${AUTH_EXT}                 auth/login
&{ADMIN_CREDENTIALS}        username=admin    password=password
${BRANDING_FORM}            css=div.branding-form
${RBC_CALENDAR}             css=div.rbc-calendar
${LOGIN_HEADER}             css=h2[data-testid="login-header"]
${LET_ME_HACK_BUTTON}       Let me hack!


*** Test Cases ***
URL Navigation Test
    Open Browser    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]    browser=Chrome
    Click Button    ${LET_ME_HACK_BUTTON}
    ${cookies}    Get Cookies
    Should Be Equal    ${cookies}    ${BANNER_COOKIE}[name]=${BANNER_COOKIE}[value]
    Close All Browsers

Admin URL Navigation Test
    Open Browser    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}    browser=Chrome
    Click Button    ${LET_ME_HACK_BUTTON}
    Wait Until Page Contains Element    ${LOGIN_HEADER}
    Close All Browsers

Message URL Navigation Test
    ${response}    POST
    ...    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${AUTH_EXT}
    ...    json=${ADMIN_CREDENTIALS}
    ${beer}    Get From Dictionary    ${response.headers}    Set-Cookie
    ${ale}    Split String    ${beer}    separator=;
    ${token}    Split String    ${ale}[0]    separator==
    Open Browser    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}    browser=Chrome
    Add Cookie    &{BANNER_COOKIE}
    Add Cookie    name=token    value=${token}[1]    domain=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][DOMAIN]
    Reload Page
    Goto    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_MESSAGES_EXT}
    Wait Until Page Contains Element    css=div.messages
    Close All Browsers

Report URL Navigation Test
    ${response}    POST
    ...    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${AUTH_EXT}
    ...    json=${ADMIN_CREDENTIALS}
    ${beer}    Get From Dictionary    ${response.headers}    Set-Cookie
    ${ale}    Split String    ${beer}    separator=;
    ${token}    Split String    ${ale}[0]    separator==
    Open Browser    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}    browser=Chrome
    Add Cookie    &{BANNER_COOKIE}
    Add Cookie    name=token    value=${token}[1]    domain=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][DOMAIN]
    Reload Page
    Goto    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_REPORT_EXT}
    Wait Until Page Contains Element    ${RBC_CALENDAR}
    Close All Browsers

Branding URL Navigation Test
    ${response}    POST
    ...    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${AUTH_EXT}
    ...    json=${ADMIN_CREDENTIALS}
    ${beer}    Get From Dictionary    ${response.headers}    Set-Cookie
    ${ale}    Split String    ${beer}    separator=;
    ${token}    Split String    ${ale}[0]    separator==
    Open Browser    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}    browser=Chrome
    Add Cookie    &{BANNER_COOKIE}
    Add Cookie    name=token    value=${token}[1]    domain=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][DOMAIN]
    Reload Page
    Goto    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_BRANDING_EXT}
    Wait Until Page Contains Element    ${BRANDING_FORM}
    Close All Browsers
