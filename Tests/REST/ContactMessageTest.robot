*** Settings ***
Resource        Resources/REST/Authentication.resource
Resource        Resources/REST/Messages.resource

Test Tags       rest-api    contact-message    admin


*** Variables ***
&{MESSAGE_BODY}
...                 name=sdf
...                 email=sdf@sdf
...                 phone=sdfsdfsdfsdf
...                 subject=sdfsd
...                 description=sdfsdfsdfsdfsdfsdfsdf


*** Test Cases ***
Verify Message Endpoint Returns OK
    [Documentation]    Verify the message endpoint returns a 200 OK
    Post Request To Message Endpoint    json=${MESSAGE_BODY}
    Request Should Be Successful

Verify Admin Can Read Message
    ${response}    Post Request To Authentication Endpoint    &{ADMIN_CREDENTIALS}
    ${token_cookie}    Get Token Cookie From Response    ${response}
    ${response}    Get Request From Message Endpoint    ${token_cookie}
    ${false_reads}    Get False Reads From Message Response    ${response}
    ${before_read}    Get Length    ${false_reads}
    ${id}    Get Id Of Second False Read    ${false_reads}
    ${response}    Get Request From Message Count Endpoint    ${token_cookie}
    VAR    ${before_count}    ${response.json()}
    Put Request To Read Message Endpoint    ${id}    ${token_cookie}
    Get Request From One Message Endpoint    ${id}    ${token_cookie}
    ${response}    Get Request From Message Endpoint    ${token_cookie}
    ${false_reads}    Get False Reads From Message Response    ${response}
    ${after_read}    Get Length    ${false_reads}
    ${response}    Get Request From Message Count Endpoint    ${token_cookie}
    VAR    ${after_count}    ${response.json()}
    Verify Count And Read Are Correct    ${before_count}    ${after_count}    ${before_read}    ${after_read}


*** Keywords ***
Verify Count And Read Are Correct
    [Arguments]    ${before_count}    ${after_count}    ${before_read}    ${after_read}
    ${before_count_value}    Get From Dictionary    ${before_count}    count    ${NONE}
    ${after_count_value}    Get From Dictionary    ${after_count}    count    ${NONE}
    Should Be Equal    ${before_count_value-1}    ${after_count_value}
    Should Be Equal    ${before_read-1}    ${after_read}
