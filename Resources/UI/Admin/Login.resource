*** Settings ***
Resource    Resources/Common/Selenium.resource


*** Keywords ***
Click Login Button
    Wait Until Element Is Enabled    id=doLogin
    Click Button    Login

Enter Password
    [Arguments]    ${password}
    VAR    ${login_password_input}    id=password
    Wait Until Page Contains Element    ${login_password_input}
    Input Password    ${login_password_input}    ${password}

Enter Username
    [Arguments]    ${username}
    VAR    ${login_username_input}    id=username
    Wait Until Page Contains Element    ${login_username_input}
    Input Text    ${login_username_input}    ${username}

Wait For Login Header To Load
    VAR    ${login_header}    css=h2[data-testid="login-header"]
    Wait Until Page Contains Element    ${login_header}
    Wait Until Element Is Visible    ${login_header}
