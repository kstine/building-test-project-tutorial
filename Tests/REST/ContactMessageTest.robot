*** Comments ***
# robotcode: ignore[VariableNotFound]


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
Verify Admin Can Read Message
    [Setup]    Test Setup
    ${before_false_reads}    Get False Reads From Message Endpoint    ${TOKEN_COOKIE}
    ${id}    Get Id Of Second False Read    ${before_false_reads}
    ${before_count}    Get Count Body From Count Endpoint    ${TOKEN_COOKIE}
    Put Request To Read Message Endpoint    ${id}    ${TOKEN_COOKIE}
    Get Request From One Message Endpoint    ${id}    ${TOKEN_COOKIE}
    ${after_false_reads}    Get False Reads From Message Endpoint    ${TOKEN_COOKIE}
    ${after_count}    Get Count Body From Count Endpoint    ${TOKEN_COOKIE}
    Verify Count And Read Are Correct
    ...    ${before_count}
    ...    ${after_count}
    ...    ${before_false_reads}
    ...    ${after_false_reads}


*** Keywords ***
Test Setup
    Create RB Session
    Post Request To Message Endpoint    json=${MESSAGE_BODY}
    ${token_cookie}    Get Token From Authentication Endpoint    &{ADMIN_CREDENTIALS}
    VAR    ${TOKEN_COOKIE}    ${token_cookie}    scope=TEST    # robocop: off=no-test-variable

Verify Count And Read Are Correct
    [Arguments]    ${before_count}    ${after_count}    ${before_false_reads}    ${after_false_reads}
    ${before_read}    Get Length    ${before_false_reads}
    ${after_read}    Get Length    ${after_false_reads}
    ${before_count_value}    Get From Dictionary    ${before_count}    count    ${0}
    ${after_count_value}    Get From Dictionary    ${after_count}    count    ${0}
    Should Be Equal    ${before_count_value-1}    ${after_count_value}
    Should Be Equal    ${before_read-1}    ${after_read}
