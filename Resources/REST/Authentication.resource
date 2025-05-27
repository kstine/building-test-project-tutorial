*** Settings ***
Library     Collections
Library     String
Resource    Resources/Common/Requests.resource


*** Keywords ***
Get Token Cookie From Response
    [Arguments]    ${response}
    TRY
        VAR    ${cookie_dict}    ${response.json()}
    EXCEPT    AS    ${error}
        Log    ${error}    ERROR
        VAR    ${cookie_dict}    token=${NONE}
    END
    RETURN    ${cookie_dict}

Post On Session To Authentication Endpoint
    [Arguments]    ${alias}    ${username}    ${password}
    VAR    ${url}    ${RB_REST_API}/${RB_REST_EXT.AUTH}
    VAR    &{json}    username=${username}    password=${password}
    ${response}    POST On Session    ${alias}    ${url}    json=${json}
    RETURN    ${response}
