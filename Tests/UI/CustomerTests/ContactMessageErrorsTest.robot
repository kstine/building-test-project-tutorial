*** Settings ***
Documentation       Example test file.

Library             SeleniumLibrary

Test Tags           ui-api    contact-message    customer


*** Variables ***
&{PRODUCTION_URL_DATA}
...                         DOMAIN=automationintesting.online
...                         URL=https://automationintesting.online
&{TEST_URL_DATA}
...                         DOMAIN=tomtebook-pro.local
...                         URL=http://tomtebook-pro.local:8080
&{BOOKING_URL_DATA}         PROD=${PRODUCTION_URL_DATA}    TEST=${TEST_URL_DATA}
${BOOKING_ENVIRONMENT}      PROD
&{BANNER_COOKIE}
...                         name=banner
...                         value=true
...                         domain=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][DOMAIN]
${NAME_INPUT}               css=input[id="name"]
${EMAIL_INPUT}              css=input[id="email"]
${PHONE_INPUT}              css=input[id="phone"]
${SUBJECT_INPUT}            css=input[id="subject"]
${MESSAGE_TEXTAREA}         css=textarea[id="description"]
${SUBMIT_BUTTON_TEXT}       Submit
${SUBMIT_BUTTON}            css=button[id="submitContact"]
${ALERT_BOX}                css=div.alert-danger
${NAME_BLANK_ALERT}         Name may not be blank
${EMAIL_BLANK_ALERT}        Email may not be blank
${EMAIL_FORM_ALERT}         must be a well-formed email address
${PHONE_BLANK_ALERT}        Phone may not be blank
${PHONE_LENGTH_ALERT}       Phone must be between 11 and 21 characters.
${SUBJECT_BLANK_ALERT}      Subject may not be blank
${SUBJECT_LENGTH_ALERT}     Subject must be between 5 and 100 characters.
${MESSAGE_BLANK_ALERT}      Message may not be blank
${MESSAGE_LENGTH_ALERT}     Message must be between 20 and 2000 characters.


*** Test Cases ***
Verify Error Messages Are Correct
    [Tags]    error-messages
    [Template]    Test Template
    ${EMPTY}    c@    ${SPACE*11}    ${EMPTY}    ${SPACE}


*** Keywords ***
Test Template
    [Arguments]    ${name}    ${email}    ${phone}    ${subject}    ${message}
    [Setup]    New Web Browser
    GROUP     Enter Test Contact Message Data
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

New Web Browser
    [Arguments]    ${add_banner_cookie}=${TRUE}
    Open Browser    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]    browser=Chrome
    IF    ${add_banner_cookie}
        Add Cookie    &{BANNER_COOKIE}
        Reload Page
    END

Enter Name Into Contact Form
    [Arguments]    ${name}
    Wait Until Element Is Visible    ${NAME_INPUT}
    Input Text    ${NAME_INPUT}    ${name}

Enter Email Into Contact Form
    [Arguments]    ${email}
    Wait Until Element Is Visible    ${EMAIL_INPUT}
    Input Text    ${EMAIL_INPUT}    ${email}

Enter Phone Into Contact Form
    [Arguments]    ${phone}
    Wait Until Element Is Visible    ${PHONE_INPUT}
    Input Text    ${PHONE_INPUT}    ${phone}

Enter Subject Into Contact Form
    [Arguments]    ${subject}
    Wait Until Element Is Visible    ${SUBJECT_INPUT}
    Input Text    ${SUBJECT_INPUT}    ${subject}

Enter Message Into Contact Form
    [Arguments]    ${message}
    Wait Until Element Is Visible    ${MESSAGE_TEXTAREA}
    Input Text    ${MESSAGE_TEXTAREA}    ${message}

Click Submit Button On The Contact Form
    Wait Until Element Is Enabled    ${SUBMIT_BUTTON}
    Click Button    ${SUBMIT_BUTTON_TEXT}

Verify Blank Name Alerts
    [Arguments]    ${name}
    Wait Until Page Contains Element    ${ALERT_BOX}
    IF    $name is None or '${name}' == '${EMPTY}' or $name.isspace()
        Element Should Contain    ${ALERT_BOX}    ${NAME_BLANK_ALERT}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${NAME_BLANK_ALERT}
    END

Verify Blank Email Alerts
    [Arguments]    ${email}
    Wait Until Page Contains Element    ${ALERT_BOX}
    IF    '${email}' == '${EMPTY}' or $email.isspace()
        Element Should Contain    ${ALERT_BOX}    ${EMAIL_BLANK_ALERT}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${EMAIL_BLANK_ALERT}
    END

Verify Well Formed Email Alerts
    [Arguments]    ${email}
    Wait Until Page Contains Element    ${ALERT_BOX}
    IF    ${{ re.match(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', $email) }}
        Element Should Not Contain    ${ALERT_BOX}    ${EMAIL_FORM_ALERT}
    ELSE
        Element Should Contain    ${ALERT_BOX}    ${EMAIL_FORM_ALERT}
    END

Verify Blank Phone Alerts
    [Arguments]    ${phone}
    IF    '${phone}' == '${EMPTY}' or $phone.isspace()
        Element Should Contain    ${ALERT_BOX}    ${PHONE_BLANK_ALERT}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${PHONE_BLANK_ALERT}
    END

Verify Phone Length Alerts
    [Arguments]    ${phone}
    IF    len($phone) < 11 or len($phone) > 20
        Element Should Contain    ${ALERT_BOX}    ${PHONE_LENGTH_ALERT}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${PHONE_LENGTH_ALERT}
    END

Verify Blank Subject Alerts
    [Arguments]    ${subject}
    IF    '${subject}' == '${EMPTY}' or $subject.isspace()
        Element Should Contain    ${ALERT_BOX}    ${SUBJECT_BLANK_ALERT}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${SUBJECT_BLANK_ALERT}
    END

Verify Subject Length Alerts
    [Arguments]    ${subject}
    IF    len($subject) < 5 or len($subject) > 100
        Element Should Contain    ${ALERT_BOX}    ${SUBJECT_LENGTH_ALERT}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${SUBJECT_LENGTH_ALERT}
    END

Verify Blank Message Alerts
    [Arguments]    ${message}
    IF    '${message}' == '${EMPTY}' or $message.isspace()
        Element Should Contain    ${ALERT_BOX}    ${MESSAGE_BLANK_ALERT}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${MESSAGE_BLANK_ALERT}
    END

Verify Message Length Alerts
    [Arguments]    ${message}
    IF    len($message) < 20 or len($message) > 2000
        Element Should Contain    ${ALERT_BOX}    ${MESSAGE_LENGTH_ALERT}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${MESSAGE_LENGTH_ALERT}
    END
