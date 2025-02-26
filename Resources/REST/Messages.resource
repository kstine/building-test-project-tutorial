*** Settings ***
Library     Collections
Resource    Resources/Common/Requests.resource


*** Variables ***
&{INCLUDE_CREDENTIALS}
...                         headers=${COMMON_HEADERS}
...                         credentials=include


*** Keywords ***
Post Request To Message Endpoint
    [Arguments]    ${json}
    ${response}    POST    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${MESSAGE_EXT}/
    ...    headers=${COMMON_HEADERS}
    ...    json=${json}
    ...    cookies=${BANNER_COOKIE}
    RETURN    ${response}

Get Request From Message Endpoint
    [Arguments]    ${token_cookie}
    ${response}    GET    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${MESSAGE_EXT}/
    ...    cookies=${token_cookie}
    RETURN    ${response}

Get Request From Message Count Endpoint
    [Arguments]    ${token_cookie}
    ${response}    GET    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${MESSAGE_COUNT_EXT}
    ...    cookies=${token_cookie}
    RETURN    ${response}

Put Request To Read Message Endpoint
    [Arguments]    ${id}    ${token_cookie}
    ${response}    PUT    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${MESSAGE_EXT}/${id}/${READ_EXT}
    ...    cookies=${token_cookie}
    ...    json=${INCLUDE_CREDENTIALS}
    ...    headers=${COMMON_HEADERS}
    RETURN    ${response}

Get Request From One Message Endpoint
    [Arguments]    ${id}    ${token_cookie}
    ${response}    GET    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${MESSAGE_EXT}/${id}
    ...    cookies=${token_cookie}
    RETURN    ${response}

Get False Reads From Message Response
    [Arguments]    ${response}
    ${messages}    Get From Dictionary    ${response.json()}    messages    ${NONE}
    ${false_reads}    Evaluate    [message for message in $messages if message['read'] == False]
    RETURN    ${false_reads}

Get Id Of Second False Read
    [Arguments]    ${false_reads}
    ${false_read}    Get From List    ${false_reads}    1
    ${id}    Get From Dictionary    ${false_read}    id    ${NONE}
    RETURN    ${id}
