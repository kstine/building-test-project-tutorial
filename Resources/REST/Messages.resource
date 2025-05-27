*** Settings ***
Library     Collections
Resource    Resources/Common/Requests.resource


*** Variables ***
&{INCLUDE_CREDENTIALS}
...                         headers=${COMMON_HEADERS}
...                         credentials=include


*** Keywords ***
Get False Reads From Message Response
    [Arguments]    ${response}
    ${messages}    Get From Dictionary    ${response.json()}    messages    ${NONE}
    ${false_reads}    Evaluate    [message for message in $messages if message['read'] == False]
    RETURN    ${false_reads}

Get Id Of Second False Read
    [Arguments]    ${false_reads}
    TRY
        ${false_read}    Get From List    ${false_reads}    1
        ${id}    Get From Dictionary    ${false_read}    id    ${NONE}
    EXCEPT    AS    ${error}
        Log    ${error}    ERROR
        VAR    ${id}    ${NONE}
    END
    RETURN    ${id}

Get Request From Message Count Endpoint
    [Arguments]    ${alias}
    VAR    ${url}    ${RB_REST_API}/${RB_REST_EXT.MESSAGE_COUNT}
    ${response}    GET On Session    ${alias}    url=${url}
    RETURN    ${response}

Get Request From Message Endpoint
    [Arguments]    ${alias}
    VAR    ${url}    ${RB_REST_API}/${RB_REST_EXT.MESSAGE}/
    ${response}    Get On Session    ${alias}    url=${url}
    RETURN    ${response}

Get Request From One Message Endpoint
    [Arguments]    ${alias}    ${id}
    VAR    ${url}    ${RB_REST_API}/${RB_REST_EXT.MESSAGE}/${id}
    ${response}    GET On Session    ${alias}    url=${url}
    RETURN    ${response}

Post Request To Message Endpoint
    [Arguments]    ${alias}    ${json}
    VAR    ${url}    ${RB_REST_API}/${RB_REST_EXT.MESSAGE}/
    ${response}    POST On Session    ${alias}    ${url}    json=${json}
    RETURN    ${response}

Put Request To Read Message Endpoint
    [Arguments]    ${alias}    ${id}
    VAR    ${url}    ${RB_REST_API}/${RB_REST_EXT.MESSAGE}/${id}/${RB_REST_EXT.READ}
    VAR    &{INCLUDE_CREDENTIALS}    success=${TRUE}
    ${response}    PUT On Session    ${alias}    url=${url}    json=${INCLUDE_CREDENTIALS}
    RETURN    ${response}
