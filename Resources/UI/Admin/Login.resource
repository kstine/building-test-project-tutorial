*** Settings ***
Resource    Resources/Common/Selenium.resource


*** Variables ***
${LOGIN_USERNAME_INPUT}     id=username
${LOGIN_PASSWORD_INPUT}     id=password
${LOGIN_BUTTON}             id=doLogin
${LOGIN_BUTTON_TEXT}        Login
${LOGIN_HEADER}             css=h2[data-testid="login-header"]


*** Keywords ***
Wait For Login Header To Load
    Wait Until Page Contains Element    ${LOGIN_HEADER}
    Wait Until Element Is Visible    ${LOGIN_HEADER}

Enter Username
    [Arguments]    ${username}
    Wait Until Page Contains Element    ${LOGIN_USERNAME_INPUT}
    Input Text    ${LOGIN_USERNAME_INPUT}    ${username}

Enter Password
    [Arguments]    ${password}
    Wait Until Page Contains Element    ${LOGIN_PASSWORD_INPUT}
    Input Password    ${LOGIN_PASSWORD_INPUT}    ${password}

Click Login Button
    Wait Until Element Is Enabled    ${LOGIN_BUTTON}
    Click Button    ${LOGIN_BUTTON_TEXT}
