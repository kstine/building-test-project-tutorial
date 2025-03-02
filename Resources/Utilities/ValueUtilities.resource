*** Settings ***
Documentation       Utilities For Value Evaluations


*** Keywords ***
Email Should Be Well Formed
    [Arguments]    ${email}
    ${result}    Evaluate
    ...    re.match(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$", "${email}") is not None
    ...    modules=re
    RETURN    ${result}

Email Should Not Be Well Formed
    [Arguments]    ${email}
    ${result}    Email Should Be Well Formed    ${email}
    IF    ${result}    RETURN    ${False}    ELSE    RETURN    ${True}

Is Value None Empty Or Space
    [Arguments]    ${value}
    ${is_nes}    Value Is None    ${value}
    IF    ${is_nes}
        RETURN    ${is_nes}
    ELSE
        ${is_nes}    Value Is Empty    ${value}
        IF    ${is_nes}
            RETURN    ${is_nes}
        ELSE
            ${is_nes}    Value Is Space    ${value}
            RETURN    ${is_nes}
        END
    END

Value Is None
    [Arguments]    ${value}
    ${is_none}    Evaluate    $value is None
    RETURN    ${is_none}

Value Is Empty
    [Arguments]    ${value}
    IF    '${value}' == '${EMPTY}'
        RETURN    ${True}
    ELSE
        RETURN    ${False}
    END

Value Is Space
    [Arguments]    ${value}
    TRY
        ${is_space}    Evaluate    $value.isspace()
    EXCEPT    AS    ${error}
        Log    ${error}    WARN
        VAR    ${is_space}    ${False}
    END
    RETURN    ${is_space}

Value Is Between Lengths
    [Arguments]    ${value}    ${min_length}    ${max_length}
    ${value_length}    Get Length    ${value}
    IF    ${value_length} > ${min_length} or ${value_length} < ${max_length}
        RETURN    ${True}
    ELSE
        RETURN    ${False}
    END

Value Is Not Between Lengths
    [Arguments]    ${value}    ${min_length}    ${max_length}
    ${value_length}    Get Length    ${value}
    IF    $value_length < $min_length or $value_length > $max_length
        RETURN    ${True}
    ELSE
        RETURN    ${False}
    END
