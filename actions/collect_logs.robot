*** Settings ***
Library     DataLogging
*** Keywords ***
Start Collect Logs
    [Documentation]
    ...    This keyword is used to start collect the logs
    ...    
    ...    *Examples:*
    ...    | Satrt Collect Logs |
    ...    | ${alias}=              |  Satrt Collect Logs |
    [Arguments]     ${alias}=master        ${adb}=${True}      ${console}=${True}      ${slog2}=${True}
    Start Console Log
    [return]    ${alias}

Stop Collect Logs
    [Documentation]
    ...    This keyword is used to stop collect the logs
    ...    
    ...    *Examples:*
    ...    | Stop Collect Logs |
    [Arguments]     ${alias}=master
    Log     Logcat and slog2 logs will save after all tests finished
    Stop Console Log    ${alias}
 




