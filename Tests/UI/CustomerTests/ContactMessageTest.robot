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
    Open Browser    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]    browser=Chrome
    Add Cookie    &{BANNER_COOKIE}
    Reload Page
    Wait Until Element Is Visible    ${NAME_INPUT}
    Input Text    ${NAME_INPUT}    ${MESSAGE_BODY}[name]
    Input Text    ${EMAIL_INPUT}    ${MESSAGE_BODY}[email]
    Input Text    ${PHONE_INPUT}    ${MESSAGE_BODY}[phone]
    Input Text    ${SUBJECT_INPUT}    ${MESSAGE_BODY}[subject]
    Input Text    ${MESSAGE_TEXTAREA}    ${MESSAGE_BODY}[description]
    Click Button    ${SUBMIT_BUTTON_TEXT}
    Wait Until Page Contains    Thanks for getting in touch ${MESSAGE_BODY}[name]!
    Element Should Contain    ${CONFIRMATION_MESSAGE}[HEADER]    ${CONFIRMATION_MESSAGE}[HEADER_TEXT]
    Element Should Contain    ${CONFIRMATION_MESSAGE}[SUBJECT]    ${MESSAGE_BODY}[subject]
    Element Should Contain    ${CONFIRMATION_MESSAGE}[ASAP]    ${CONFIRMATION_MESSAGE}[ASAP_TEXT]
    Close All Browsers
