*** Settings ***
Library     RequestsLibrary
Resource    Environment.resource


*** Variables ***
&{COMMON_HEADERS}       Accept=application/json    Content-Type=application/json
&{RB_REST_EXT}
...                     AUTH=auth/login
...                     MESSAGE=message
...                     MESSAGE_COUNT=message/count
...                     READ=read
${DEFAULT_ALIAS}        rb-session


*** Keywords ***
Create RB Session
    Create Session
    ...        alias=${DEFAULT_ALIAS}
    ...        url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]
    ...        headers=${COMMON_HEADERS}

Update RB Session
    [Arguments]    ${alias}=${DEFAULT_ALIAS}
    ...            ${headers}=${COMMON_HEADERS}
    ...            ${cookies}=${BANNER_COOKIE}
    Update Session
    ...        alias=${alias}
    ...        cookies=${cookies}
    ...        headers=${headers}
