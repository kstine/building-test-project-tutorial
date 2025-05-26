*** Settings ***
Library     Collections
Library     SeleniumLibrary
Resource    Environment.resource


*** Variables ***
${BROWSER}              Chrome
# &{RB_URL_EXT}
# ...    ADMIN=\#/admin
# ...    REPORT=report
# ...    BRANDING=branding
# ...    MESSAGES=messages
&{RB_URL_EXT}
...                     Rooms=#rooms
...                     Booking=#booking
...                     Amenities=#amenities
...                     Location=#location
...                     Contact=#contact
...                     Admin=admin
&{RB_ADMIN_URL_EXT}
...                     Rooms=admin/rooms
...                     Report=admin/report
...                     Branding=admin/branding
...                     Messages=admin/message


*** Keywords ***
Add Token Cookie
    [Arguments]    ${token_cookie}
    ${token_value}    Get From Dictionary    ${token_cookie}    token    ${NONE}
    Add Cookie    name=token    value=${token_value}    domain=${BOOKING_DOMAIN}
    Reload Page

Click Let Me Hack Button
    Click Button    Let me hack!

New Web Browser
    [Arguments]    ${add_banner_cookie}=${TRUE}
    Open Browser    url=${BOOKING_URL}    browser=${BROWSER}
    IF    ${add_banner_cookie}
        Add Cookie    &{BANNER_COOKIE}
        Reload Page
    END

Verify Banner Cookie
    ${cookies}    Get Cookies
    Should Contain    ${cookies}    ${BANNER_COOKIE}[name]=${BANNER_COOKIE}[value]
