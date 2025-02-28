*** Settings ***
Resource    Resources/Common/Selenium.resource


*** Variables ***
&{CONFIRMATION_MESSAGE}
...                         HEADER=css=div.row.contact > div:nth-child(2) > div > p:nth-child(2)
...                         HEADER_TEXT=We'll get back to you about
...                         SUBJECT=css=div.row.contact > div:nth-child(2) > div > p:nth-child(3)
...                         ASAP=css=div.row.contact > div:nth-child(2) > div > p:nth-child(4)
...                         ASAP_TEXT=as soon as possible.
${ALERT_BOX}                css=div.alert-danger
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
Click Submit Button On The Contact Form
    Wait Until Element Is Enabled    css=button[id="submitContact"]
    Click Button    Submit

Email Should Be Well Formed
    [Arguments]    ${email}
    ${result}    Evaluate
    ...    re.match(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', $email) is not None
    ...    modules=re
    RETURN    ${result}

Enter Contact Message Data
    [Arguments]    ${name}    ${email}    ${phone}    ${subject}    ${message}
    Enter Name Into Contact Form    ${name}
    Enter Email Into Contact Form    ${email}
    Enter Phone Into Contact Form    ${phone}
    Enter Subject Into Contact Form    ${subject}
    Enter Message Into Contact Form    ${message}
    Click Submit Button On The Contact Form

Enter Email Into Contact Form
    [Arguments]    ${email}
    VAR    ${email_input}    css=input[id="email"]
    Wait Until Element Is Visible    ${email_input}
    Input Text    ${email_input}    ${email}

Enter Message Into Contact Form
    [Arguments]    ${message}
    VAR    ${message_textarea}    css=textarea[id="description"]
    Wait Until Element Is Visible    ${message_textarea}
    Input Text    ${message_textarea}    ${message}

Enter Name Into Contact Form
    [Arguments]    ${name}
    VAR    ${name_input}    css=input[id="name"]
    Wait Until Element Is Visible    ${name_input}
    Input Text    ${name_input}    ${name}

Enter Phone Into Contact Form
    [Arguments]    ${phone}
    VAR    ${phone_input}    css=input[id="phone"]
    Wait Until Element Is Visible    ${phone_input}
    Input Text    ${phone_input}    ${phone}

Enter Subject Into Contact Form
    [Arguments]    ${subject}
    VAR    ${subject_input}    css=input[id="subject"]
    Wait Until Element Is Visible    ${subject_input}
    Input Text    ${subject_input}    ${subject}

Verify Blank Email Alerts
    [Arguments]    ${email}
    Wait For Alert Box
    IF    '${email}' == '${EMPTY}' or $email.isspace()
        Element Should Contain    ${ALERT_BOX}    ${CONTACT_FORM_ALERTS.EMAIL_BLANK}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${CONTACT_FORM_ALERTS.EMAIL_BLANK}
    END

Verify Blank Message Alerts
    [Arguments]    ${message}
    Wait For Alert Box
    IF    '${message}' == '${EMPTY}' or $message.isspace()
        Element Should Contain    ${ALERT_BOX}    ${CONTACT_FORM_ALERTS.MESSAGE_BLANK}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${CONTACT_FORM_ALERTS.MESSAGE_BLANK}
    END

Verify Blank Name Alerts
    [Arguments]    ${name}
    Wait For Alert Box
    IF    $name is None or '${name}' == '${EMPTY}' or $name.isspace()
        Element Should Contain    ${ALERT_BOX}    ${CONTACT_FORM_ALERTS.NAME_BLANK}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${CONTACT_FORM_ALERTS.NAME_BLANK}
    END

Verify Blank Phone Alerts
    [Arguments]    ${phone}
    Wait For Alert Box
    IF    '${phone}' == '${EMPTY}' or $phone.isspace()
        Element Should Contain    ${ALERT_BOX}    ${CONTACT_FORM_ALERTS.PHONE_BLANK}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${CONTACT_FORM_ALERTS.PHONE_BLANK}
    END

Verify Blank Subject Alerts
    [Arguments]    ${subject}
    Wait For Alert Box
    IF    '${subject}' == '${EMPTY}' or $subject.isspace()
        Element Should Contain    ${ALERT_BOX}    ${CONTACT_FORM_ALERTS.SUBJECT_BLANK}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${CONTACT_FORM_ALERTS.SUBJECT_BLANK}
    END

Verify Confirmation Message After Submitting Message
    [Arguments]    ${name}    ${subject}
    Wait Until Page Contains    Thanks for getting in touch ${name}!
    Element Should Contain    ${CONFIRMATION_MESSAGE}[HEADER]    ${CONFIRMATION_MESSAGE}[HEADER_TEXT]
    Element Should Contain    ${CONFIRMATION_MESSAGE}[SUBJECT]    ${subject}
    Element Should Contain    ${CONFIRMATION_MESSAGE}[ASAP]    ${CONFIRMATION_MESSAGE}[ASAP_TEXT]

Verify Message Length Alerts
    [Arguments]    ${message}
    IF    len($message) < 20 or len($message) > 2000
        Element Should Contain    ${ALERT_BOX}    ${CONTACT_FORM_ALERTS.MESSAGE_LENGTH}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${CONTACT_FORM_ALERTS.MESSAGE_LENGTH}
    END

Verify Phone Length Alerts
    [Arguments]    ${phone}
    IF    len($phone) < 11 or len($phone) > 20
        Element Should Contain    ${ALERT_BOX}    ${CONTACT_FORM_ALERTS.PHONE_LENGTH}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${CONTACT_FORM_ALERTS.PHONE_LENGTH}
    END

Verify Subject Length Alerts
    [Arguments]    ${subject}
    IF    len($subject) < 5 or len($subject) > 100
        Element Should Contain    ${ALERT_BOX}    ${CONTACT_FORM_ALERTS.SUBJECT_LENGTH}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${CONTACT_FORM_ALERTS.SUBJECT_LENGTH}
    END

Verify Well Formed Email Alerts
    [Arguments]    ${email}
    ${is_valid_email}    Email Should Be Well Formed    ${email}
    Wait Until Page Contains Element    ${ALERT_BOX}
    IF    not $is_valid_email
        Element Should Contain    ${ALERT_BOX}    ${CONTACT_FORM_ALERTS.EMAIL_FORM}
    ELSE
        Element Should Not Contain    ${ALERT_BOX}    ${CONTACT_FORM_ALERTS.EMAIL_FORM}
    END

Wait For Alert Box
    Wait Until Element Is Visible    ${ALERT_BOX}
