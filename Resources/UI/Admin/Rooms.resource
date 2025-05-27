*** Settings ***
Resource    Resources/Common/Selenium.resource


*** Variables ***
&{ROOM_HEADER}          ROW=css=div.rowHeader
@{ROOM_COLUMN_NAMES}
...                     Room #
...                     Type
...                     Accessible
...                     Price
...                     Room details


*** Keywords ***
Verify Room Header Row Columns
    Wait Until Element Is Visible    ${ROOM_HEADER.ROW}
    ${elements}    Get WebElements    ${ROOM_HEADER.ROW}
    ${room_header_texts}    Evaluate    [ele.text for ele in $elements]
    Lists Should Be Equal    ${room_header_texts}    ${ROOM_COLUMN_NAMES}
