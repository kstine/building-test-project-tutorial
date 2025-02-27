*** Settings ***
Resource    Resources/Common/Selenium.resource


*** Variables ***
${BOOKING_MGT_TITLE}    B&B Booking Management


*** Keywords ***
Wait For Booking Management To Load
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_URL_EXT.ADMIN}
    Wait Until Page Contains    ${BOOKING_MGT_TITLE}

Click Rooms Navbar Link
    VAR    ${rooms_link}    xpath://li/a[contains(@href, "admin")][text()="Rooms"]
    Wait Until Element Is Visible    ${rooms_link}
    Click Element    ${rooms_link}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_URL_EXT.ADMIN}/

Click Report Navbar Link
    VAR    ${report_link}    id=reportLink
    Wait Until Element Is Visible    ${report_link}
    Click Element    ${report_link}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_URL_EXT.ADMIN}/${RB_URL_EXT.REPORT}

Click Branding Navbar Link
    VAR    ${branding_link}    id=brandingLink
    Wait Until Element Is Visible    ${branding_link}
    Click Element    ${branding_link}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_URL_EXT.ADMIN}/${RB_URL_EXT.BRANDING}

Click Notifications Navbar Link
    VAR    ${notifications_link}    css=a.nav-link[href="${RB_URL_EXT.ADMIN}/${RB_URL_EXT.MESSAGES}"]
    Wait Until Element Is Visible    ${notifications_link}
    Click Element    ${notifications_link}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_URL_EXT.ADMIN}/${RB_URL_EXT.MESSAGES}

Click Front Page Navbar Link
    VAR    ${front_page_link}    id=frontPageLink
    Wait Until Element Is Visible    ${front_page_link}
    Click Element    ${front_page_link}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/

Click Logout Navbar Link
    VAR    ${logout_link}    css=a.nav-link[href="${RB_URL_EXT.ADMIN}"]
    Wait Until Element Is Visible    ${logout_link}
    Click Element    ${logout_link}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_URL_EXT.ADMIN}
