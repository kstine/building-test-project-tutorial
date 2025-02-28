*** Settings ***
Resource        Resources/REST/Authentication.resource
Resource        Resources/REST/Messages.resource

Test Tags       rest-api    contact-message    admin


*** Variables ***
&{MESSAGE_BODY}
...                 name=sdf
...                 email=sdf@sdf.sdf
...                 phone=sdfsdfsdfsdf
...                 subject=sdfsdf
...                 description=sdfsdfsdfsdfsdfsdfsdf


*** Test Cases ***
Verify Message Endpoint Returns OK
    [Documentation]    Verify the message endpoint returns a 200 OK
    Post Request To Message Endpoint    json=${MESSAGE_BODY}
    Request Should Be Successful

Verify Admin Can Read Message
    ${token_cookie}    Get Token From Authentication Endpoint
    ${false_reads}    Get False Reads From Message Endpoint    ${token_cookie}
    ${before_read}    Get Length    ${false_reads}
    ${id}    Get Id Of Second False Read    ${false_reads}
    ${before_count}    Get Count Body From Count Endpoint    ${token_cookie}
    Put Request To Read Message Endpoint    ${id}    ${token_cookie}
    Get Request From One Message Endpoint    ${id}    ${token_cookie}
    ${false_reads}    Get False Reads From Message Endpoint    ${token_cookie}
    ${after_read}    Get Length    ${false_reads}
    ${after_count}    Get Count Body From Count Endpoint    ${token_cookie}
    Verify Count And Read Are Correct    ${before_count}    ${after_count}    ${before_read}    ${after_read}


*** Keywords ***
Verify Count And Read Are Correct
    [Arguments]    ${before_count}    ${after_count}    ${before_read}    ${after_read}
    ${before_count_value}    Get From Dictionary    ${before_count}    count    ${0}
    ${after_count_value}    Get From Dictionary    ${after_count}    count    ${0}
    Should Be Equal    ${before_count_value-1}    ${after_count_value}
    Should Be Equal    ${before_read-1}    ${after_read}

Get Token From Authentication Endpoint
    ${response}    Post Request To Authentication Endpoint    &{ADMIN_CREDENTIALS}
    ${token_cookie}    Get Token Cookie From Response    ${response}
    RETURN    ${token_cookie}

Get False Reads From Message Endpoint
    [Arguments]    ${token_cookie}
    ${response}    Get Request From Message Endpoint    ${token_cookie}
    ${false_reads}    Get False Reads From Message Response    ${response}
    RETURN    ${false_reads}

Get Count Body From Count Endpoint
    [Arguments]    ${token_cookie}
    ${response}    Get Request From Message Count Endpoint    ${token_cookie}
    RETURN    ${response.json()}
