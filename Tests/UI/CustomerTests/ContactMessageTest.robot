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
${BOOKING_ENVIRONMENT}      TEST
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
&{CONFIRMATION_MESSAGE}
...                         HEADER=css=div.row.contact > div:nth-child(2) > div > p:nth-child(2)
...                         HEADER_TEXT=We'll get back to you about
...                         SUBJECT=css=div.row.contact > div:nth-child(2) > div > p:nth-child(3)
...                         ASAP=css=div.row.contact > div:nth-child(2) > div > p:nth-child(4)
...                         ASAP_TEXT=as soon as possible.
&{MESSAGE_BODY}
...                         name=Bob Builder
...                         email=bob@builder.com
...                         phone=05552312222
...                         subject=Building things
...                         description=I am a very lengthy sentence and would love to know more about building hotels.


*** Test Cases ***
Verify Confirmation Message After Submitting Message
    [Tags]    happy-path
    [Setup]    New Web Browser
    Enter Name Into Contact Form    ${MESSAGE_BODY}[name]
    Enter Email Into Contact Form    ${MESSAGE_BODY}[email]
    Enter Phone Into Contact Form    ${MESSAGE_BODY}[phone]
    Enter Subject Into Contact Form    ${MESSAGE_BODY}[subject]
    Enter Message Into Contact Form    ${MESSAGE_BODY}[description]
    Click Submit Button On The Contact Form
    Verify Confirmation Message After Submitting Message    ${MESSAGE_BODY}[name]    ${MESSAGE_BODY}[subject]
    [Teardown]    Close All Browsers


*** Keywords ***
Verify Confirmation Message After Submitting Message
    [Arguments]    ${name}    ${subject}
    Wait Until Page Contains    Thanks for getting in touch ${name}!
    Element Should Contain    ${CONFIRMATION_MESSAGE}[HEADER]    ${CONFIRMATION_MESSAGE}[HEADER_TEXT]
    Element Should Contain    ${CONFIRMATION_MESSAGE}[SUBJECT]    ${subject}
    Element Should Contain    ${CONFIRMATION_MESSAGE}[ASAP]    ${CONFIRMATION_MESSAGE}[ASAP_TEXT]

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
