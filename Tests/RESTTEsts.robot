*** Settings ***
Library     Collections
Library     String
Library     RequestsLibrary
Library     JSONLibrary


*** Variables ***
&{headers}      Accept=application/json    Content-Type=application/json
&{json_data}
...             headers=${headers}
...             credentials=include


*** Test Cases ***
Verify Contact Endpoint
    VAR    &{headers}
    ...    Accept=application/json
    ...    Content-Type=application/json
    VAR    &{body}
    ...    name=sdf
    ...    email=sdf@sdf
    ...    phone=sdfsdfsdfsdf
    ...    subject=sdfsd
    ...    description=sdfsdfsdfsdfsdfsdfsdf
    VAR    &{cookie}
    ...    name=banner    value=true    domain=automationintesting.online
    POST    https://automationintesting.online/message/
    ...    headers=${headers}
    ...    json=${body}
    ...    cookies=${cookie}

Check Contact Message As An Admin
    VAR    &{body}    username=admin    password=password
    ${response}    POST    url=https://automationintesting.online/auth/login    json=${body}
    ${beer}    Get From Dictionary    ${response.headers}    Set-Cookie
    ${ale}    Split String    ${beer}    separator=;
    ${token}    Split String    ${ale}[0]    separator==
    ${response}    GET    url=https://automationintesting.online/message/
    ...    cookies=${{ {"token": $token[1]} }}
    ${messages}    Set Variable    ${{$response.json()['messages']}}
    ${false_reads}    Evaluate    [message for message in $messages if message['read'] == False]
    ${before_read}    Get Length    ${false_reads}
    ${response}    GET    url=https://automationintesting.online/message/count
    ...    cookies=${{ {"token": $token[1]} }}
    ${before_count}    Set Variable    ${response.json()}
    ${id}    Evaluate    $false_reads[1]['id']
    ${response}    PUT    url=https://automationintesting.online/message/${id}/read
    ...    cookies=${{ {"token": $token[1]} }}
    ...    json=${json_data}
    ...    headers=${headers}
    Log    ${response}    CONSOLE
    ${response}    GET    url=https://automationintesting.online/message/${id}
    ...    cookies=${{ {"token": $token[1]} }}
    Log    ${response.json()}
    ${response}    GET    url=https://automationintesting.online/message/
    ...    cookies=${{ {"token": $token[1]} }}
    ${messages}    Set Variable    ${{ $response.json()['messages'] }}
    ${false_reads}    Evaluate    [message for message in $messages if message['read'] == False]
    ${after_read}    Get Length    ${false_reads}
    ${response}    GET    url=https://automationintesting.online/message/count
    ...    cookies=${{ {"token": $token[1]} }}
    ${after_count}    Set Variable    ${response.json()}
    Should Be Equal    ${{ $before_count['count']-1 }}    ${after_count}[count]
    Should Be Equal    ${before_read-1}    ${after_read}
