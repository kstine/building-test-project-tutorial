*** Settings ***
Documentation       Example test file.

Resource            Resources/UI/Customer/Contact.resource

Suite Teardown      Close All Browsers

Test Tags           ui-api    contact-message    customer


*** Test Cases ***
Verify Error Messages Are Correct
    [Tags]    error-messages
    [Template]    Test Template
    ${EMPTY}    c@    ${SPACE*11}    ${EMPTY}    ${SPACE}


*** Keywords ***
Test Template
    [Arguments]    ${name}    ${email}    ${phone}    ${subject}    ${message}
    [Setup]    New Web Browser
    Enter Contact Message Data    ${name}    ${email}    ${phone}    ${subject}    ${message}
    Verify Error Messages    ${name}    ${email}    ${phone}    ${subject}    ${message}
    [Teardown]    Close Browser

Verify Error Messages
    [Arguments]    ${name}    ${email}    ${phone}    ${subject}    ${message}
    Verify Blank Name Alerts    ${name}
    Verify Blank Email Alerts    ${email}
    Verify Well Formed Email Alerts    ${email}
    Verify Blank Phone Alerts    ${phone}
    Verify Phone Length Alerts    ${phone}
    Verify Blank Subject Alerts    ${subject}
    Verify Subject Length Alerts    ${subject}
    Verify Blank Message Alerts    ${message}
    Verify Message Length Alerts    ${message}
