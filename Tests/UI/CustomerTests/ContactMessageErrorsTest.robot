*** Settings ***
Documentation       Example test file.

Resource            Resources/UI/Customer/Contact.resource

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
    GROUP    Enter Test Contact Message Data
        Enter Name Into Contact Form    ${name}
        Enter Email Into Contact Form    ${email}
        Enter Phone Into Contact Form    ${phone}
        Enter Subject Into Contact Form    ${subject}
        Enter Message Into Contact Form    ${message}
        Click Submit Button On The Contact Form
    END
    GROUP    Verify Error Messages
        Verify Blank Name Alerts    ${name}
        Verify Blank Email Alerts    ${email}
        Verify Well Formed Email Alerts    ${email}
        Verify Blank Phone Alerts    ${phone}
        Verify Phone Length Alerts    ${phone}
        Verify Blank Subject Alerts    ${subject}
        Verify Subject Length Alerts    ${subject}
        Verify Blank Message Alerts    ${message}
        Verify Message Length Alerts    ${message}
    END
    [Teardown]    Close All Browsers
