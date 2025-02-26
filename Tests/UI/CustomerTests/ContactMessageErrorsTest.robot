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
    Open Browser    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]    browser=Chrome
    Add Cookie    &{BANNER_COOKIE}
    Reload Page
    Wait Until Element Is Visible    ${NAME_INPUT}
    Input Text    ${NAME_INPUT}    ${name}
    Input Text    ${EMAIL_INPUT}    ${email}
    Input Text    ${PHONE_INPUT}    ${phone}
    Input Text    ${SUBJECT_INPUT}    ${subject}
    Input Text    ${MESSAGE_TEXTAREA}    ${message}
    Click Button    ${SUBMIT_BUTTON_TEXT}
    Wait Until Page Contains Element    ${ALERT_BOX}
    IF    $name is None or '${name}' == '${EMPTY}' or $name.isspace()
        Element Should Contain    ${ALERT_BOX}    ${NAME_BLANK_ALERT}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${NAME_BLANK_ALERT}
    END
    IF    '${email}' == '${EMPTY}' or $email.isspace()
        Element Should Contain    ${ALERT_BOX}    ${EMAIL_BLANK_ALERT}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${EMAIL_BLANK_ALERT}
    END
    IF    ${{ re.match(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', $email) }}
        Element Should Not Contain    ${ALERT_BOX}    ${EMAIL_FORM_ALERT}
    ELSE
        Element Should Contain    ${ALERT_BOX}    ${EMAIL_FORM_ALERT}
    END
    IF    '${phone}' == '${EMPTY}' or $phone.isspace()
        Element Should Contain    ${ALERT_BOX}    ${PHONE_BLANK_ALERT}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${PHONE_BLANK_ALERT}
    END
    IF    len($phone) < 11 or len($phone) > 20
        Element Should Contain    ${ALERT_BOX}    ${PHONE_LENGTH_ALERT}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${PHONE_LENGTH_ALERT}
    END
    IF    '${subject}' == '${EMPTY}' or $subject.isspace()
        Element Should Contain    ${ALERT_BOX}    ${SUBJECT_BLANK_ALERT}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${SUBJECT_BLANK_ALERT}
    END
    IF    len($subject) < 5 or len($subject) > 100
        Element Should Contain    ${ALERT_BOX}    ${SUBJECT_LENGTH_ALERT}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${SUBJECT_LENGTH_ALERT}
    END
    IF    '${message}' == '${EMPTY}' or $message.isspace()
        Element Should Contain    ${ALERT_BOX}    ${MESSAGE_BLANK_ALERT}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${MESSAGE_BLANK_ALERT}
    END
    IF    len($message) < 20 or len($message) > 2000
        Element Should Contain    ${ALERT_BOX}    ${MESSAGE_LENGTH_ALERT}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${MESSAGE_LENGTH_ALERT}
    END
    Close All Browsers
