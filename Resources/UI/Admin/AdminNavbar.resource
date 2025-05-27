*** Settings ***
Resource    Resources/Common/Selenium.resource


*** Variables ***
${BOOKING_MGT_TITLE}        Restful Booker Platform Demo
&{ADMIN_NAVBAR_LINKS}
...                         Rooms=${RB_ADMIN_URL_EXT.Rooms}
...                         Report=${RB_ADMIN_URL_EXT.Report}
...                         Branding=${RB_ADMIN_URL_EXT.Branding}
...                         Messages=${RB_ADMIN_URL_EXT.Messages}


*** Keywords ***
Click "${link_text}" Admin Navbar Link
    ${href}    Get From Dictionary    ${ADMIN_NAVBAR_LINKS}    ${link_text}    ${EMPTY}
    VAR    ${navbar_link}    xpath://li/a[contains(@href, "/${href}")][contains(text(), "${link_text}")]
    Wait Until Element Is Visible    ${navbar_link}
    Click Element    ${navbar_link}
    Wait Until Location Is    ${BOOKING_URL}/${href}

Click Front Page Admin Navbar Link
    VAR    ${front_page_link}    id=frontPageLink
    Wait Until Element Is Visible    ${front_page_link}
    Click Element    ${front_page_link}
    Log    Wait for Front Page To Appear

Click Logout Admin Navbar Link
    VAR    ${logout_link}    xpath=//button[text()="Logout"]
    Wait Until Element Is Visible    ${logout_link}
    Click Element    ${logout_link}
    Log    Wait for Front Page To Appear

Wait For Admin Location
    Wait Until Location Is    ${BOOKING_URL}/${RB_URL_EXT.ADMIN}

Wait For Booking Management To Load
    Wait Until Location Contains    ${BOOKING_URL}/${RB_ADMIN_URL_EXT.Rooms}
    Wait Until Page Contains    ${BOOKING_MGT_TITLE}

Wait For "${link_text}" Admin Location
    ${href}    Get From Dictionary    ${ADMIN_NAVBAR_LINKS}    ${link_text}    ${EMPTY}
    Wait Until Location Is    ${BOOKING_URL}/${href}

Wait For "${link_text}" Location
    Wait Until Location Is    ${BOOKING_URL}/${RB_ADMIN_URL_EXT}[${link_text}]
