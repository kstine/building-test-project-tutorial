*** Settings ***
Resource    Resources/Common/Selenium.resource


*** Keywords ***
Click Submit Button On The Contact Form
    Wait Until Element Is Enabled    css=button[id="submitContact"]
    Click Button    Submit

Enter Contact Message Data
    [Arguments]    ${name}    ${email}    ${phone}    ${subject}    ${message}
    IF    $name is not None    Enter Name Into Contact Form    ${name}
    IF    $email is not None    Enter Email Into Contact Form    ${email}
    IF    $phone is not None    Enter Phone Into Contact Form    ${phone}
    IF    $subject is not None    Enter Subject Into Contact Form    ${subject}
    IF    $message is not None    Enter Message Into Contact Form    ${message}
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
