*** Settings ***
Documentation       Interface Resource for REST Api

Resource            Authentication.resource
Resource            Messages.resource
Resource            Session.resource


*** Keywords ***
Get Token From Authentication Endpoint
    [Arguments]    ${alias}=${DEFAULT_ALIAS}    ${username}=${EMPTY}    ${password}=${EMPTY}
    ${response}    Post On Session To Authentication Endpoint    ${alias}    ${username}    ${password}
    ${token_cookie}    Get Token Cookie From Response    ${response}
    RETURN    ${token_cookie}

Get False Reads From Message Endpoint
    [Arguments]    ${alias}=${DEFAULT_ALIAS}
    ${response}    Get Request From Message Endpoint    ${alias}
    ${false_reads}    Get False Reads From Message Response    ${response}
    RETURN    ${false_reads}

Get Count Body From Count Endpoint
    [Arguments]    ${alias}=${DEFAULT_ALIAS}
    ${response}    Get Request From Message Count Endpoint    ${alias}
    RETURN    ${response.json()}
