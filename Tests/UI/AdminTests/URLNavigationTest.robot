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
${MESSAGES_CONTAINER}       css=div.messages
${LOGIN_HEADER}             css=h2[data-testid="login-header"]
${LET_ME_HACK_BUTTON}       Let me hack!
${ROOM_HEADER_ROW}          css=div.container > div > div > div > div.row
${ROOM_HEADER_COLUMNS}      css=div.container > div > div > div > div.row > div
@{ROOM_COLUMN_NAMES}        Room #    Type    Accessible    Price    Room details


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
    Wait Until Element Is Visible    ${ROOM_HEADER_ROW}
    Verify Room Header Row Columns
    [Teardown]    Close All Browsers

Report URL Navigation Test
    ${response}    Post Request To Authentication Endpoint    &{ADMIN_CREDENTIALS}
    ${token_cookie}    Get Token Cookie From Response    ${response}
    New Web Browser
    Add Token Cookie    ${token_cookie}
    Navigate To Reports By URL
    Wait Until Element Is Visible    ${RBC_CALENDAR}
    [Teardown]    Close All Browsers

Branding URL Navigation Test
    ${response}    Post Request To Authentication Endpoint    &{ADMIN_CREDENTIALS}
    ${token_cookie}    Get Token Cookie From Response    ${response}
    New Web Browser
    Add Token Cookie    ${token_cookie}
    Navigate To Branding By URL
    Wait Until Element Is Visible    ${BRANDING_FORM}
    [Teardown]    Close All Browsers

Message URL Navigation Test
    ${response}    Post Request To Authentication Endpoint    &{ADMIN_CREDENTIALS}
    ${token_cookie}    Get Token Cookie From Response    ${response}
    New Web Browser
    Add Token Cookie    ${token_cookie}
    Navigate To Messages By URL
    Wait Until Element Is Visible    ${MESSAGES_CONTAINER}
    [Teardown]    Close All Browsers


*** Keywords ***
New Web Browser
    [Arguments]    ${add_banner_cookie}=${TRUE}
    Open Browser    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]    browser=Chrome
    IF    ${add_banner_cookie}
        Add Cookie    &{BANNER_COOKIE}
        Reload Page
    END

Click Let Me Hack Button
    Click Button    ${LET_ME_HACK_BUTTON}

Verify Banner Cookie
    ${cookies}    Get Cookies
    Should Contain    ${cookies}    ${BANNER_COOKIE}[name]=${BANNER_COOKIE}[value]

Navigate To Admin Login Page
    Go To    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}

Wait For Login Header To Load
    Wait Until Page Contains Element    ${LOGIN_HEADER}
    Wait Until Element Is Visible    ${LOGIN_HEADER}

Post Request To Authentication Endpoint
    [Arguments]    ${username}    ${password}
    VAR    &{json}    username=${username}    password=${password}
    ${response}    POST    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${AUTH_EXT}
    ...    json=${json}
    RETURN    ${response}

Get Token Cookie From Response
    [Arguments]    ${response}
    ${cookie_string}    Get From Dictionary    ${response.headers}    Set-Cookie
    TRY
        Should Contain    ${cookie_string}    token
        ${token_path_list}    Split String    ${cookie_string}    separator=;
        ${token_string}    Get From List    ${token_path_list}    0
        ${token_value_list}    Split String    ${token_string}    separator==
        ${value}    Get From List    ${token_value_list}    1
        VAR    &{cookie_dict}    token=${value}
    EXCEPT    AS    ${error}
        Log    ${error}    ERROR
        VAR    &{cookie_dict}    token=${NONE}
    END
    RETURN    ${cookie_dict}

Add token Cookie
    [Arguments]    ${token_cookie}
    ${token_value}    Get From Dictionary    ${token_cookie}    token    ${NONE}
    Add Cookie    name=token    value=${token_value}    domain=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][DOMAIN]
    Reload Page

Verify Room Header Row Columns
    ${room_header_text}    Get Text    ${ROOM_HEADER_ROW}
    ${room_header_texts}    Split String    ${room_header_text}    separator=\n
    Lists Should Be Equal    ${room_header_texts}    ${ROOM_COLUMN_NAMES}

Navigate To Rooms By URL
    Go To    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/

Navigate To Branding By URL
    Go To    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_BRANDING_EXT}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_BRANDING_EXT}

Navigate To Messages By URL
    Go To    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_MESSAGES_EXT}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_MESSAGES_EXT}

Navigate To Reports By URL
    Go To    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_REPORT_EXT}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_REPORT_EXT}
