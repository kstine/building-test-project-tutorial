*** Settings ***
Resource    Resources/Common/Selenium.resource


*** Keywords ***
Navigate To Admin Login Page
    VAR    ${url}    ${BOOKING_URL}/${RB_URL_EXT.ADMIN}
    Go To    ${url}
    Wait Until Location Is    ${url}

Navigate To Branding By URL
    VAR    ${url}    ${BOOKING_URL}/${RB_URL_EXT.ADMIN}/${RB_URL_EXT.BRANDING}
    Go To    ${url}
    Wait Until Location Is    ${url}

Navigate To Messages By URL
    VAR    ${url}    ${BOOKING_URL}/${RB_URL_EXT.ADMIN}/${RB_URL_EXT.MESSAGES}
    Go To    ${url}
    Wait Until Location Is    ${url}

Navigate To Reports By URL
    VAR    ${url}    ${BOOKING_URL}/${RB_URL_EXT.ADMIN}/${RB_URL_EXT.REPORT}
    Go To    ${url}
    Wait Until Location Is    ${url}

Navigate To Rooms By URL
    VAR    ${url}    ${BOOKING_URL}/${RB_URL_EXT.ADMIN}/
    Go To    ${url}
    Wait Until Location Is    ${url}
