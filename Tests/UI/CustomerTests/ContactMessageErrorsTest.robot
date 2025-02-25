*** Settings ***
Documentation       Example test file.

Library             SeleniumLibrary

Test Tags           ui-api    contact-message    customer

*** Test Cases ***
Verify Error Messages Are Correct
    [Tags]    error-messages
    [Template]    Test Template
    ${EMPTY}    c@    ${SPACE*11}    ${EMPTY}    ${SPACE}

*** Keywords ***
Test Template
    [Arguments]    ${name}    ${email}    ${phone}    ${subject}    ${message}
    # Open Browser    url=https://automationintesting.online    browser=Chrome
    # Add Cookie    name=banner    value=true    domain=automationintesting.online
    Open Browser    url=http://tomtebook-pro.local:8080/    browser=Chrome
    Add Cookie    name=banner    value=true    domain=tomtebook-pro.local
    Reload Page
    Wait Until Element Is Visible    css:input[id="name"]
    Input Text    css:input[id="name"]    ${name}
    Input Text    css:input[id="email"]    ${email}
    Input Text    css:input[id="phone"]    ${phone}
    Input Text    css:input[id="subject"]    ${subject}
    Input Text    css:textarea[id="description"]    ${message}
    Click Button    Submit
    Wait Until Page Contains Element    css:div.alert-danger
    IF    $name is None or '${name}' == '${EMPTY}' or $name.isspace()
        Element Should Contain    css:div.alert-danger    Name may not be blank
    ELSE
        Element Should Not Contain    css:div.alert-danger    Name may not be blank
    END
    IF    '${email}' == '${EMPTY}' or $email.isspace()
        Element Should Contain    css:div.alert-danger    Email may not be blank
    ELSE
        Element Should Not Contain    css:div.alert-danger    Email may not be blank
    END
    IF    ${{ re.match(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', $email) }}
        Element Should Not Contain    css:div.alert-danger    must be a well-formed email address
    ELSE
        Element Should Contain    css:div.alert-danger    must be a well-formed email address
    END
    IF    '${phone}' == '${EMPTY}' or $phone.isspace()
        Element Should Contain    css:div.alert-danger    Phone may not be blank
    ELSE
        Element Should Not Contain    css:div.alert-danger    Phone may not be blank
    END
    IF    len($phone) < 11 or len($phone) > 20
        Element Should Contain    css:div.alert-danger    Phone must be between 11 and 21 characters.
    ELSE
        Element Should Not Contain    css:div.alert-danger    Phone must be between 11 and 21 characters.
    END
    IF    '${subject}' == '${EMPTY}' or $subject.isspace()
        Element Should Contain    css:div.alert-danger    Subject may not be blank
    ELSE
        Element Should Not Contain    css:div.alert-danger    Subject may not be blank
    END
    IF    len($subject) < 5 or len($subject) > 100
        Element Should Contain    css:div.alert-danger    Subject must be between 5 and 100 characters.
    ELSE
        Element Should Not Contain    css:div.alert-danger    Subject must be between 5 and 100 characters.
    END
    IF    '${message}' == '${EMPTY}' or $message.isspace()
        Element Should Contain    css:div.alert-danger    Message may not be blank
    ELSE
        Element Should Not Contain    css:div.alert-danger    Message may not be blank
    END
    IF    len($message) < 20 or len($message) > 2000
        Element Should Contain    css:div.alert-danger    Message must be between 20 and 2000 characters.
    ELSE
        Element Should Not Contain    css:div.alert-danger    Message must be between 20 and 2000 characters.
    END
    Close All Browsers