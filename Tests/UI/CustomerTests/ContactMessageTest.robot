*** Settings ***
Documentation       Example test file.

Library             SeleniumLibrary

Test Tags           ui-api    contact-message    customer


*** Test Cases ***
Verify Confirmation Message After Submitting Message
    [Tags]    happy-path
    Open Browser    url=https://automationintesting.online    browser=Chrome
    Add Cookie    name=banner    value=true    domain=automationintesting.online
    # Open Browser    url=http://tomtebook-pro.local:8080/    browser=Chrome
    # Add Cookie    name=banner    value=true    domain=tomtebook-pro.local
    Reload Page
    Wait Until Element Is Visible    css:input[id="name"]
    Input Text    css:input[id="name"]    Bob Builder
    Input Text    css:input[id="email"]    bob@builder.com
    Input Text    css:input[id="phone"]    05552312222
    Input Text    css:input[id="subject"]    Building things
    Input Text
    ...    css:textarea[id="description"]
    ...    I am a very lengthy sentence and would love to know more about building hotels.
    Click Button    Submit
    Wait Until Page Contains    Thanks for getting in touch Bob Builder!
    Element Should Contain
    ...    css:div.row.contact > div:nth-child(2) > div > p:nth-child(2)
    ...    We'll get back to you about
    Element Should Contain    css:div.row.contact > div:nth-child(2) > div > p:nth-child(3)    Building things
    Element Should Contain    css:div.row.contact > div:nth-child(2) > div > p:nth-child(4)    as soon as possible.
    Close All Browsers