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
${BOOKING_ENVIRONMENT}      TEST
&{COMMON_HEADERS}           Accept=application/json    Content-Type=application/json
&{INCLUDE_CREDENTIALS}
...                         headers=${COMMON_HEADERS}
...                         credentials=include
&{MESSAGE_BODY}
...                         name=sdf
...                         email=sdf@sdf.sdf
...                         phone=sdfsdfsdfsdf
...                         subject=sdfsdf
...                         description=sdfsdfsdfsdfsdfsdfsdf
&{BANNER_COOKIE}            name=banner    value=true    domain=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][DOMAIN]
&{ADMIN_CREDENTIALS}        username=admin    password=password
${AUTH_EXT}                 auth/login
${MESSAGE_EXT}              message
${MESSAGE_COUNT_EXT}        message/count
${READ_EXT}                 read


*** Test Cases ***
Verify Message Endpoint Returns OK
    POST    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${MESSAGE_EXT}/
    ...    headers=${COMMON_HEADERS}
    ...    json=${MESSAGE_BODY}
    ...    cookies=${BANNER_COOKIE}

Verify Admin Can Read Message
    ${response}    POST
    ...    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${AUTH_EXT}
    ...    json=${ADMIN_CREDENTIALS}
    ${beer}    Get From Dictionary    ${response.headers}    Set-Cookie
    ${ale}    Split String    ${beer}    separator=;
    ${token}    Split String    ${ale}[0]    separator==
    ${response}    GET    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${MESSAGE_EXT}/
    ...    cookies=${{ {"token": $token[1]} }}
    ${messages}    Set Variable    ${{$response.json()['messages']}}
    ${false_reads}    Evaluate    [message for message in $messages if message['read'] == False]
    ${before_read}    Get Length    ${false_reads}
    ${response}    GET    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${MESSAGE_COUNT_EXT}
    ...    cookies=${{ {"token": $token[1]} }}
    ${before_count}    Set Variable    ${response.json()}
    ${id}    Evaluate    $false_reads[1]['id']
    ${response}    PUT    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${MESSAGE_EXT}/${id}/${READ_EXT}
    ...    cookies=${{ {"token": $token[1]} }}
    ...    json=${INCLUDE_CREDENTIALS}
    ...    headers=${COMMON_HEADERS}
    Log    ${response}    CONSOLE
    ${response}    GET    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${MESSAGE_EXT}/${id}
    ...    cookies=${{ {"token": $token[1]} }}
    Log    ${response.json()}
    ${response}    GET    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${MESSAGE_EXT}/
    ...    cookies=${{ {"token": $token[1]} }}
    ${messages}    Set Variable    ${{ $response.json()['messages'] }}
    ${false_reads}    Evaluate    [message for message in $messages if message['read'] == False]
    ${after_read}    Get Length    ${false_reads}
    ${response}    GET    url=${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${MESSAGE_COUNT_EXT}
    ...    cookies=${{ {"token": $token[1]} }}
    ${after_count}    Set Variable    ${response.json()}
    Should Be Equal    ${{ $before_count['count']-1 }}    ${after_count}[count]
    Should Be Equal    ${before_read-1}    ${after_read}
