*** Settings ***
Resource    Resources/Common/Selenium.resource


*** Keywords ***
Wait For Front Page To Load
    TRY
        Wait Until Location Is    ${BOOKING_URL}
    EXCEPT    AS    ${error}
        Log    ${error}    INFO
        Log    Trying again...    INFO
        Wait Until Location Is    ${BOOKING_URL}/
    END

Navigate To "${location}" Login Page
    VAR    ${url}    ${BOOKING_URL}/${RB_URL_EXT}[${location}]
    Go To    ${url}
    Wait Until Location Is    ${url}

Navigate To Admin "${location}" By URL
    VAR    ${url}    ${BOOKING_URL}/${RB_ADMIN_URL_EXT}[${location}]
    Go To    ${url}
    Wait Until Location Is    ${url}
