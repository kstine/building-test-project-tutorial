*** Settings ***
Resource    Resources/Common/Selenium.resource


*** Variables ***
${BOOKING_MGT_TITLE}    B&B Booking Management


*** Keywords ***
Click Branding Navbar Link
    VAR    ${branding_link}    id=brandingLink
    Wait Until Element Is Visible    ${branding_link}
    Click Element    ${branding_link}

Click Front Page Navbar Link
    VAR    ${front_page_link}    id=frontPageLink
    Wait Until Element Is Visible    ${front_page_link}
    Click Element    ${front_page_link}
    Wait Until Location Is
    ...    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/

Click Logout Navbar Link
    VAR    ${logout_link}    css=a.nav-link[href="${RB_URL_EXT.ADMIN}"]
    Wait Until Element Is Visible    ${logout_link}
    Click Element    ${logout_link}
    Wait Until Location Is
    ...    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_URL_EXT.ADMIN}

Click Notifications Navbar Link
    VAR    ${notifications_link}    css=a.nav-link[href="${RB_URL_EXT.ADMIN}/${RB_URL_EXT.MESSAGES}"]
    Wait Until Element Is Visible    ${notifications_link}
    Click Element    ${notifications_link}

Click Report Navbar Link
    VAR    ${report_link}    id=reportLink
    Wait Until Element Is Visible    ${report_link}
    Click Element    ${report_link}

Click Rooms Navbar Link
    VAR    ${rooms_link}    xpath://li/a[contains(@href, "admin")][text()="Rooms"]
    Wait Until Element Is Visible    ${rooms_link}
    Click Element    ${rooms_link}

Wait For Admin Location
    Wait Until Location Is
    ...    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_URL_EXT.ADMIN}

Wait For Booking Management To Load
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_URL_EXT.ADMIN}
    Wait Until Page Contains    ${BOOKING_MGT_TITLE}

Wait For Branding Location
    Wait Until Location Is
    ...    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_URL_EXT.ADMIN}/${RB_URL_EXT.BRANDING}

Wait For Messages Location
    Wait Until Location Is
    ...    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_URL_EXT.ADMIN}/${RB_URL_EXT.MESSAGES}

Wait For Report Location
    Wait Until Location Is
    ...    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_URL_EXT.ADMIN}/${RB_URL_EXT.REPORT}

Wait For Rooms Location
    Wait Until Location Is
    ...    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_URL_EXT.ADMIN}/
