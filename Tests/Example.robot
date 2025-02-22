*** Settings ***
Documentation       Example test file.

Library             SeleniumLibrary

Test Tags           contact-message


*** Test Cases ***
Verify Confirmation Message After Submitting Message
    [Tags]    happy-path
    Open Browser    url=https://automationintesting.online    browser=Chrome    remote_url=http://localhost:4444
    Add Cookie    name=banner    value=true    domain=automationintesting.online
    # Open Browser    url=http://tomtebook-pro.local:8080/    browser=Chrome    remote_url=http://localhost:4444
    # Add Cookie    name=banner    value=true    domain=tomtebook-pro.local
    Reload Page
    Wait Until Element Is Visible    css:input[id="name"]
    Input Text    css:input[id="name"]    Bob Builder
    Input Text    css:input[id="email"]    bob@builder.com
    Input Text    css:input[id="phone"]    05552312222
    Input Text    css:input[id="subject"]    Building things
    Input Text
    ...    css:textarea[id="description"]
    ...    I am a very lengthy sentence and would love to know more about building hotels.
    Click Button    Submit
    Wait Until Page Contains    Thanks for getting in touch Bob Builder!
    Element Should Contain
    ...    css:div.row.contact > div:nth-child(2) > div > p:nth-child(2)
    ...    We'll get back to you about
    Element Should Contain    css:div.row.contact > div:nth-child(2) > div > p:nth-child(3)    Building things
    Element Should Contain    css:div.row.contact > div:nth-child(2) > div > p:nth-child(4)    as soon as possible.
    Close All Browsers

Verify Error Messages Are Correct
    [Tags]    error-messages
    [Template]    Test Template
    ${EMPTY}    c@    ${SPACE*11}    ${EMPTY}    ${SPACE}

Verify Admin Menu Tour
    [Tags]    happy-path
    # Open Browser    url=https://automationintesting.online    browser=Firefox
    # Add Cookie    name=banner    value=true    domain=automationintesting.online
    Open Browser    url=http://tomtebook-pro.local:8080/    browser=Chrome
    Add Cookie    name=banner    value=true    domain=tomtebook-pro.local
    Reload Page
    Go To    http://tomtebook-pro.local:8080/#/admin
    Wait Until Page Contains Element    id=username
    Input Text    id=username    admin
    Input Text    id=password    password
    Click Button    Login
    Wait Until Page Contains    B&B Booking Management
    Click Link    \#/admin/
    Wait Until Location Is    http://tomtebook-pro.local:8080/#/admin/
    Click Link    \#/admin/report
    Wait Until Location Is    http://tomtebook-pro.local:8080/#/admin/report
    Click Link    \#/admin/branding
    Wait Until Location Is    http://tomtebook-pro.local:8080/#/admin/branding
    Click Link    \#/admin/messages
    Wait Until Location Is    http://tomtebook-pro.local:8080/#/admin/messages
    Click Link    /
    Wait Until Location Is    http://tomtebook-pro.local:8080/
    Go Back
    Wait Until Location Is    http://tomtebook-pro.local:8080/#/admin/messages
    Click Link    \#/admin
    Close All Browsers


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
