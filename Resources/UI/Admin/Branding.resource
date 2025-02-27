*** Settings ***
Resource    Resources/Common/Selenium.resource


*** Variables ***
${BRANDING_FORM}    css=div.branding-form


*** Keywords ***
Wait For Branding Form To Be Visible
    Wait Until Element Is Visible    ${BRANDING_FORM}
