*** Settings ***
Library     RequestsLibrary
Resource    Environment.resource


*** Variables ***
${AUTH_EXT}             auth/login
${MESSAGE_EXT}          message
${MESSAGE_COUNT_EXT}    message/count
${READ_EXT}             read
&{COMMON_HEADERS}       Accept=application/json    Content-Type=application/json
