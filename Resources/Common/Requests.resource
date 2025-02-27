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
