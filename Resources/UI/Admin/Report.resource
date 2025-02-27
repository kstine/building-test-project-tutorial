*** Settings ***
Resource    Resources/Common/Selenium.resource


*** Variables ***
${RBC_CALENDAR}     css=div.rbc-calendar


*** Keywords ***
Wait For Report Calendar To Be Visible
    Wait Until Element Is Visible    ${RBC_CALENDAR}
