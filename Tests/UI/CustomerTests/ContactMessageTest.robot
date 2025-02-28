*** Settings ***
Documentation       Example test file.

Resource            Resources/UI/Customer/Contact.resource

Suite Teardown      Close All Browsers
Test Setup          New Web Browser
Test Teardown       Close Browser

Test Tags           ui-api    contact-message    customer


*** Variables ***
&{MESSAGE_BODY}
...                 name=Bob Builder
...                 email=bob@builder.com
...                 phone=05552312222
...                 subject=Building things
...                 description=I am a very lengthy sentence and would love to know more about building hotels.


*** Test Cases ***
Verify Confirmation Message After Submitting Message
    [Tags]    happy-path
    Enter Name Into Contact Form    ${MESSAGE_BODY}[name]
    Enter Email Into Contact Form    ${MESSAGE_BODY}[email]
    Enter Phone Into Contact Form    ${MESSAGE_BODY}[phone]
    Enter Subject Into Contact Form    ${MESSAGE_BODY}[subject]
    Enter Message Into Contact Form    ${MESSAGE_BODY}[description]
    Click Submit Button On The Contact Form
    Verify Confirmation Message After Submitting Message    ${MESSAGE_BODY}[name]    ${MESSAGE_BODY}[subject]
