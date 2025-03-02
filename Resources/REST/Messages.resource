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
    [Arguments]    ${token_cookie}
    VAR    ${url}    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_REST_EXT.MESSAGE_COUNT}
    ${response}    GET    url=${url}    cookies=${token_cookie}    headers=${COMMON_HEADERS}
    RETURN    ${response}

Get Request From Message Endpoint
    [Arguments]    ${token_cookie}
    VAR    ${url}    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_REST_EXT.MESSAGE}/
    ${response}    GET    url=${url}    cookies=${token_cookie}    headers=${COMMON_HEADERS}
    RETURN    ${response}

Get Request From One Message Endpoint
    [Arguments]    ${id}    ${token_cookie}
    VAR    ${url}    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_REST_EXT.MESSAGE}/${id}
    ${response}    GET    url=${url}    cookies=${token_cookie}    headers=${COMMON_HEADERS}
    RETURN    ${response}

Post Request To Message Endpoint
    [Arguments]    ${json}
    VAR    ${url}    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_REST_EXT.MESSAGE}/
    ${response}    POST    ${url}    cookies=${BANNER_COOKIE}    headers=${COMMON_HEADERS}    json=${json}
    RETURN    ${response}

Put Request To Read Message Endpoint
    [Arguments]    ${id}    ${token_cookie}
    VAR    ${url}    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_REST_EXT.MESSAGE}/${id}/${RB_REST_EXT.READ}
    ${response}    PUT
    ...    url=${url}
    ...    cookies=${token_cookie}
    ...    headers=${COMMON_HEADERS}
    ...    json=${INCLUDE_CREDENTIALS}
    RETURN    ${response}

Get False Reads From Message Endpoint
    [Arguments]    ${token_cookie}
    ${response}    Get Request From Message Endpoint    ${token_cookie}
    ${false_reads}    Get False Reads From Message Response    ${response}
    RETURN    ${false_reads}

Get Count Body From Count Endpoint
    [Arguments]    ${token_cookie}
    ${response}    Get Request From Message Count Endpoint    ${token_cookie}
    RETURN    ${response.json()}