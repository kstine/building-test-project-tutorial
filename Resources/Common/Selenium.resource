*** Settings ***
Library     Collections
Library     SeleniumLibrary
Resource    Environment.resource


*** Variables ***
${BROWSER}                  Chrome
${RB_ADMIN_EXT}             \#/admin
${RB_REPORT_EXT}            report
${RB_BRANDING_EXT}          branding
${RB_MESSAGES_EXT}          messages
${LET_ME_HACK_BUTTON}       Let me hack!


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
    Click Button    ${LET_ME_HACK_BUTTON}

Add Token Cookie
    [Arguments]    ${token_cookie}
    ${token_value}    Get From Dictionary    ${token_cookie}    token    ${NONE}
    Add Cookie    name=token    value=${token_value}    domain=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][DOMAIN]
    Reload Page

Navigate To Admin Login Page
    Go To    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}

Navigate To Branding By URL
    Go To    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_BRANDING_EXT}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_BRANDING_EXT}

Navigate To Rooms By URL
    Go To    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/

Navigate To Messages By URL
    Go To    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_MESSAGES_EXT}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_MESSAGES_EXT}

Navigate To Reports By URL
    Go To    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_REPORT_EXT}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_REPORT_EXT}
