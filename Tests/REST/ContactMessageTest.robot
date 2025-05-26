*** Comments ***
# robotcode: ignore[VariableNotFound]


*** Settings ***
Resource        Resources/REST/RestfulBookerRestApi.resource

Test Tags       rest-api    contact-message    admin


*** Variables ***
${MESSAGE_ALIAS}    message-alias
&{MESSAGE_BODY}
...                 name=sdf
...                 email=sdf@sdf.sdf
...                 phone=sdfsdfsdfsdf
...                 subject=sdfsdf
...                 description=sdfsdfsdfsdfsdfsdfsdf


*** Test Cases ***
Verify Admin Can Read Message
    [Setup]    Test Setup
    ${before_false_reads}    Get False Reads From Message Endpoint    ${MESSAGE_ALIAS}
    ${id}    Get Id Of Second False Read    ${before_false_reads}
    ${before_count}    Get Count Body From Count Endpoint    ${MESSAGE_ALIAS}
    Put Request To Read Message Endpoint    ${MESSAGE_ALIAS}    ${id}
    Get Request From One Message Endpoint    ${MESSAGE_ALIAS}    ${id}
    ${after_false_reads}    Get False Reads From Message Endpoint    ${MESSAGE_ALIAS}
    ${after_count}    Get Count Body From Count Endpoint    ${MESSAGE_ALIAS}
    Verify Count And Read Are Correct
    ...    ${before_count}
    ...    ${after_count}
    ...    ${before_false_reads}
    ...    ${after_false_reads}
    [Teardown]    Test Teardown


*** Keywords ***
Test Setup
    Create RB Session    ${MESSAGE_ALIAS}
    Create RB Session    ${MESSAGE_ALIAS}
    Post Request To Message Endpoint    ${MESSAGE_ALIAS}    json=${MESSAGE_BODY}
    ${token_cookie}    Get Token From Authentication Endpoint    ${MESSAGE_ALIAS}    &{ADMIN_CREDENTIALS}
    Update RB Session    alias=${MESSAGE_ALIAS}    cookies=${token_cookie}

Test Teardown
    Delete All Sessions

Verify Count And Read Are Correct
    [Arguments]    ${before_count}    ${after_count}    ${before_false_reads}    ${after_false_reads}
    ${before_read}    Get Length    ${before_false_reads}
    ${after_read}    Get Length    ${after_false_reads}
    ${before_count_value}    Get From Dictionary    ${before_count}    count    ${0}
    ${after_count_value}    Get From Dictionary    ${after_count}    count    ${0}
    Should Be Equal    ${before_count_value-1}    ${after_count_value}
    Should Be Equal    ${before_read-1}    ${after_read}
