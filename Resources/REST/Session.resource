*** Settings ***
Library     Collections
Resource    Endpoints.resource
Resource    Resources/Common/Requests.resource


*** Variables ***
${DEFAULT_ALIAS}    rb-session


*** Keywords ***
Create RB Session
    [Arguments]    ${alias}=${DEFAULT_ALIAS}    ${url}=${NONE}    ${headers}=${COMMON_HEADERS}
    ${is_session}    Session Exists    ${alias}
    IF    ${is_session}
        Log    Session ${alias} exists.    CONSOLE
    ELSE
        Log    Creating session ${alias}.    CONSOLE
        IF    $url is None
            VAR    ${url}    ${BOOKING_URL}
        END
        Create Session    alias=${alias}    url=${url}    headers=${headers}
    END

Update RB Session
    [Arguments]    ${alias}=${DEFAULT_ALIAS}    ${headers}=${COMMON_HEADERS}    ${cookies}=${BANNER_COOKIE}
    Update Session    alias=${alias}    cookies=${cookies}    headers=${headers}
