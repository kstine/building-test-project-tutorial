*** Settings ***
Library     Collections
Library     SeleniumLibrary
Resource    Environment.resource


*** Variables ***
${BROWSER}          Chrome
&{RB_URL_EXT}
...                 ADMIN=\#/admin
...                 REPORT=report
...                 BRANDING=branding
...                 MESSAGES=messages


*** Keywords ***
New Web Browser
    [Arguments]    ${add_banner_cookie}=${TRUE}
    Open Browser    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]    browser=${BROWSER}
    IF    ${add_banner_cookie}
        Add Cookie    &{BANNER_COOKIE}
        Reload Page
    END

Verify Banner Cookie
    ${cookies}    Get Cookies
    Should Contain    ${cookies}    ${BANNER_COOKIE}[name]=${BANNER_COOKIE}[value]

Click Let Me Hack Button
    Click Button    Let me hack!

Add Token Cookie
    [Arguments]    ${token_cookie}
    ${token_value}    Get From Dictionary    ${token_cookie}    token    ${NONE}
    Add Cookie    name=token    value=${token_value}    domain=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][DOMAIN]
    Reload Page

Navigate To Admin Login Page
    VAR    ${url}    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_URL_EXT.ADMIN}
    Go To    ${url}
    Wait Until Location Is    ${url}

Navigate To Branding By URL
    VAR    ${url}    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_URL_EXT.ADMIN}/${RB_URL_EXT.BRANDING}
    Go To    ${url}
    Wait Until Location Is    ${url}

Navigate To Rooms By URL
    VAR    ${url}    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_URL_EXT.ADMIN}/
    Go To    ${url}
    Wait Until Location Is    ${url}

Navigate To Messages By URL
    VAR    ${url}    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_URL_EXT.ADMIN}/${RB_URL_EXT.MESSAGES}
    Go To    ${url}
    Wait Until Location Is    ${url}

Navigate To Reports By URL
    VAR    ${url}    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_URL_EXT.ADMIN}/${RB_URL_EXT.REPORT}
    Go To    ${url}
    Wait Until Location Is    ${url}
