*** Settings ***
Library     String
Resource    Resources/Common/Selenium.resource


*** Variables ***
${ROOM_HEADER_ROW}          css=div.container > div > div > div > div.row
${ROOM_HEADER_COLUMNS}      css=div.container > div > div > div > div.row > div
@{ROOM_COLUMN_NAMES}        Room #    Type    Accessible    Price    Room details


*** Keywords ***
Verify Room Header Row Columns
    ${room_header_text}    Get Text    ${ROOM_HEADER_ROW}
    ${room_header_texts}    Split String    ${room_header_text}    separator=\n
    Lists Should Be Equal    ${room_header_texts}    ${ROOM_COLUMN_NAMES}
