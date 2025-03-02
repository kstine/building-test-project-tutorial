*** Settings ***
Resource    AlertBoxPageObject.resource
Resource    Resources/Utilities/ValueUtilities.resource


*** Variables ***
&{CONFIRMATION_MESSAGE}
...                         HEADER=css=div.row.contact > div:nth-child(2) > div > p:nth-child(2)
...                         HEADER_TEXT=We'll get back to you about
...                         SUBJECT=css=div.row.contact > div:nth-child(2) > div > p:nth-child(3)
...                         ASAP=css=div.row.contact > div:nth-child(2) > div > p:nth-child(4)
...                         ASAP_TEXT=as soon as possible.
&{CONTACT_FORM_ALERTS}
...                         NAME_BLANK=Name may not be blank
...                         EMAIL_BLANK=Email may not be blank
...                         EMAIL_FORM=must be a well-formed email address
...                         PHONE_BLANK=Phone may not be blank
...                         PHONE_LENGTH=Phone must be between 11 and 21 characters.
...                         SUBJECT_BLANK=Subject may not be blank
...                         SUBJECT_LENGTH=Subject must be between 5 and 100 characters.
...                         MESSAGE_BLANK=Message may not be blank
...                         MESSAGE_LENGTH=Message must be between 20 and 2000 characters.


*** Keywords ***
Verify Blank Email Alerts
    [Arguments]    ${email}
    ${is_nes}    Is Value None Empty Or Space    ${email}
    Verify Alert Box Message    ${is_nes}    ${CONTACT_FORM_ALERTS.EMAIL_BLANK}

Verify Blank Message Alerts
    [Arguments]    ${message}
    ${is_nes}    Is Value None Empty Or Space    ${message}
    Verify Alert Box Message    ${is_nes}    ${CONTACT_FORM_ALERTS.MESSAGE_BLANK}

Verify Blank Name Alerts
    [Arguments]    ${name}
    ${is_nes}    Is Value None Empty Or Space    ${name}
    Verify Alert Box Message    ${is_nes}    ${CONTACT_FORM_ALERTS.NAME_BLANK}

Verify Blank Phone Alerts
    [Arguments]    ${phone}
    ${is_nes}    Is Value None Empty Or Space    ${phone}
    Verify Alert Box Message    ${is_nes}    ${CONTACT_FORM_ALERTS.PHONE_BLANK}

Verify Blank Subject Alerts
    [Arguments]    ${subject}
    ${is_nes}    Is Value None Empty Or Space    ${subject}
    Verify Alert Box Message    ${is_nes}    ${CONTACT_FORM_ALERTS.SUBJECT_BLANK}

Verify Confirmation Message After Submitting Message
    [Arguments]    ${name}    ${subject}
    Wait Until Page Contains    Thanks for getting in touch ${name}!
    Element Should Contain    ${CONFIRMATION_MESSAGE}[HEADER]    ${CONFIRMATION_MESSAGE}[HEADER_TEXT]
    Element Should Contain    ${CONFIRMATION_MESSAGE}[SUBJECT]    ${subject}
    Element Should Contain    ${CONFIRMATION_MESSAGE}[ASAP]    ${CONFIRMATION_MESSAGE}[ASAP_TEXT]

Verify Message Length Alerts
    [Arguments]    ${message}
    ${is_error_message}    Value Is Not Between Lengths    ${message}    ${20}    ${2000}
    Verify Alert Box Message    ${is_error_message}    error_message=${CONTACT_FORM_ALERTS.MESSAGE_LENGTH}

Verify Phone Length Alerts
    [Arguments]    ${phone}
    ${is_error_message}    Value Is Not Between Lengths    ${phone}    ${11}    ${20}
    Verify Alert Box Message    ${is_error_message}    error_message=${CONTACT_FORM_ALERTS.PHONE_LENGTH}

Verify Subject Length Alerts
    [Arguments]    ${subject}
    ${is_error_message}    Value Is Not Between Lengths    ${subject}    ${5}    ${100}
    Verify Alert Box Message    ${is_error_message}    error_message=${CONTACT_FORM_ALERTS.SUBJECT_LENGTH}

Verify Well Formed Email Alerts
    [Arguments]    ${email}
    ${is_not_valid_email}    Email Should Not Be Well Formed    ${email}
    Verify Alert Box Message    ${is_not_valid_email}    error_message=${CONTACT_FORM_ALERTS.EMAIL_FORM}
