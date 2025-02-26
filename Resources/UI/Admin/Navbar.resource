*** Settings ***
Resource    Resources/Common/Selenium.resource


*** Variables ***
${BOOKING_MGT_TITLE}                    B&B Booking Management
${ADMIN_NAVBAR_ROOMS_LINK}              xpath://li/a[contains(@href, "admin")][text()="Rooms"]
${ADMIN_NAVBAR_REPORT_LINK}             id=reportLink
${ADMIN_NAVBAR_BRANDING_LINK}           id=brandingLink
${ADMIN_NAVBAR_NOTIFICATIONS_LINK}      css=a.nav-link[href="#/admin/messages"]
${ADMIN_NAVBAR_FRONT_PAGE_LINK}         id=frontPageLink
${ADMIN_NAVBAR_LOGOUT_LINK}             css=a.nav-link[href="#/admin"]


*** Keywords ***
Wait For Booking Management To Load
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}
    Wait Until Page Contains    ${BOOKING_MGT_TITLE}

Click Rooms Navbar Link
    Wait Until Element Is Visible    ${ADMIN_NAVBAR_ROOMS_LINK}
    Click Element    ${ADMIN_NAVBAR_ROOMS_LINK}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/

Click Report Navbar Link
    Wait Until Element Is Visible    ${ADMIN_NAVBAR_REPORT_LINK}
    Click Element    ${ADMIN_NAVBAR_REPORT_LINK}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_REPORT_EXT}

Click Branding Navbar Link
    Wait Until Element Is Visible    ${ADMIN_NAVBAR_BRANDING_LINK}
    Click Element    ${ADMIN_NAVBAR_BRANDING_LINK}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_BRANDING_EXT}

Click Notifications Navbar Link
    Wait Until Element Is Visible    ${ADMIN_NAVBAR_NOTIFICATIONS_LINK}
    Click Element    ${ADMIN_NAVBAR_NOTIFICATIONS_LINK}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}/${RB_MESSAGES_EXT}

Click Front Page Navbar Link
    Wait Until Element Is Visible    ${ADMIN_NAVBAR_FRONT_PAGE_LINK}
    Click Element    ${ADMIN_NAVBAR_FRONT_PAGE_LINK}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/

Click Logout Navbar Link
    Wait Until Element Is Visible    ${ADMIN_NAVBAR_LOGOUT_LINK}
    Click Element    ${ADMIN_NAVBAR_LOGOUT_LINK}
    Wait Until Location Is    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_ADMIN_EXT}
