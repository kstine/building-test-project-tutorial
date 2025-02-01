*** Settings ***
Documentation     Example test file.


*** Variables ***
${EXAMPLE_VAR}    test


*** Test Cases ***
Verify Example Variable
    Should Be Equal    test    ${EXAMPLE_VAR}
