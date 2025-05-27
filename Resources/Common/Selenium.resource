*** Settings ***
Library     Collections
Library     SeleniumLibrary
Resource    Environment.resource


*** Variables ***
${BROWSER}              Chrome
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

New Web Browser
    Log    Opening url: ${BOOKING_URL} with browser: ${BROWSER}.     CONSOLE
    Open Browser    url=${BOOKING_URL}    browser=${BROWSER}
