*** Settings ***
Resource    Resources/Common/Selenium.resource


*** Variables ***
${MESSAGES_CONTAINER}       css=div.messages


*** Keywords ***
Wait For Messages Container To Be Visible
    Wait Until Element Is Visible    ${MESSAGES_CONTAINER}
