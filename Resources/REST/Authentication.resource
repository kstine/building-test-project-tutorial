*** Settings ***
Library     Collections
Library     String
Resource    Resources/Common/Requests.resource


*** Keywords ***
Post Request To Authentication Endpoint
    [Arguments]    ${username}    ${password}
    VAR    ${url}    ${BOOKING_URL_DATA}[${BOOKING_ENVIRONMENT}][URL]/${RB_REST_EXT.AUTH}
    VAR    &{json}    username=${username}    password=${password}
    ${response}    POST    ${url}    json=${json}
    RETURN    ${response}

Get Token Cookie From Response
    [Arguments]    ${response}
    ${cookie_string}    Get From Dictionary    ${response.headers}    Set-Cookie    token=${NONE}
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
