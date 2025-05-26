*** Settings ***
Resource    Resources/Common/Selenium.resource


*** Variables ***
${CUSTOMER_NAVBAR}          id=navbarNav
${CUSTOMER_NAVBAR_ITEM}     css=li.nav-item
&{CUSTOMER_NAVBAR_LINKS}
...                         Rooms=/${RB_URL_EXT.Rooms}
...                         Booking=/${RB_URL_EXT.Booking}
...                         Amenities=/${RB_URL_EXT.Amenities}
...                         Location=/${RB_URL_EXT.Location}
...                         Contact=/${RB_URL_EXT.Contact}
...                         Admin=/${RB_URL_EXT.Admin}


*** Keywords ***
Click "${link_text}" Navbar Link
    ${href}    Get From Dictionary    ${CUSTOMER_NAVBAR_LINKS}    ${link_text}    ${EMPTY}
    VAR    ${navbar_link}    xpath://li/a[contains(@href, "${href}")][text()="${link_text}"]
    Wait Until Element Is Visible    ${navbar_link}
    Click Element    ${navbar_link}
    Wait Until Location Is    ${BOOKING_URL}${href}
