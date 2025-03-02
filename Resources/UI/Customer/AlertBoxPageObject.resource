*** Settings ***
Resource    Resources/Common/Selenium.resource


*** Variables ***
${ALERT_BOX}    css=div.alert-danger


*** Keywords ***
Wait For Alert Box
    Wait Until Element Is Visible    ${ALERT_BOX}

Verify Alert Box Message
    [Arguments]    ${is_error_message}    ${error_message}
    Wait For Alert Box
    IF    ${is_error_message}
        Element Should Contain    ${ALERT_BOX}    ${error_message}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${error_message}
    END
