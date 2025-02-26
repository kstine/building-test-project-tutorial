*** Settings ***
Library         Collections
Library         String
Library         RequestsLibrary
Library         JSONLibrary

Test Tags       rest-api    contact-message    admin


*** Variables ***
&{PRODUCTION_URL_DATA}
...                         DOMAIN=automationintesting.online
...                         URL=https://automationintesting.online
&{TEST_URL_DATA}
...                         DOMAIN=tomtebook-pro.local
...                         URL=http://tomtebook-pro.local:8080/
&{BOOKING_URL_DATA}         PROD=${PRODUCTION_URL_DATA}    TEST=${TEST_URL_DATA}
${BOOKING_ENVIRONMENT}      PROD
&{COMMON_HEADERS}           Accept=application/json    Content-Type=application/json
&{INCLUDE_CREDENTIALS}
...                         headers=${COMMON_HEADERS}
...                         credentials=include
&{MESSAGE_BODY}
...                         name=sdf
...                         email=sdf@sdf
...                         phone=sdfsdfsdfsdf
...                         subject=sdfsd
...                         description=sdfsdfsdfsdfsdfsdfsdf
&{BANNER_COOKIE}            name=banner    value=true    domain=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][DOMAIN]
&{ADMIN_CREDENTIALS}        username=admin    password=password
${AUTH_EXT}                 auth/login
${MESSAGE_EXT}              message
${MESSAGE_COUNT_EXT}        message/count
${READ_EXT}                 read


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
Post Request To Message Endpoint
    [Arguments]    ${json}
    ${response}    POST    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${MESSAGE_EXT}/
    ...    headers=${COMMON_HEADERS}
    ...    json=${json}
    ...    cookies=${BANNER_COOKIE}
    RETURN    ${response}

Get Token Cookie From Response
    [Arguments]    ${response}
    ${cookie_string}    Get From Dictionary    ${response.headers}    Set-Cookie
    TRY
        Should Contain    ${cookie_string}    token
        ${token_path_list}    Split String    ${cookie_string}    separator=;
        ${token_string}    Get From List    ${token_path_list}    0
        ${token_value_list}    Split String    ${token_string}    separator==
        ${value}    Get From List    ${token_value_list}    1
        VAR    &{cookie_dict}    token=${value}
    EXCEPT    AS    ${error}
        Log    ${error}    ERROR
        VAR    &{cookie_dict}    token=${NONE}
    END
    RETURN    ${cookie_dict}

Post Request To Authentication Endpoint
    [Arguments]    ${username}    ${password}
    VAR    &{json}    username=${username}    password=${password}
    ${response}    POST    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${AUTH_EXT}
    ...    json=${json}
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

Verify Count And Read Are Correct
    [Arguments]    ${before_count}    ${after_count}    ${before_read}    ${after_read}
    ${before_count_value}    Get From Dictionary    ${before_count}    count    ${NONE}
    ${after_count_value}    Get From Dictionary    ${after_count}    count    ${NONE}
    Should Be Equal    ${before_count_value-1}    ${after_count_value}
    Should Be Equal    ${before_read-1}    ${after_read}
