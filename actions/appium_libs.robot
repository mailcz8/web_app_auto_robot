*** Settings ***   
Library    Process
Library    OperatingSystem
Library    AppiumLibrary  run_on_failure=Log Source
Library    String
Library    SSHLibrary

*** Variable ***
&{appium}       server=localhost    port=4723       sshport=22      local_server=localhost
&{drt}          android_ver=8.1.0       devname=192.168.111.11:5555       devudid=192.168.111.11:5555
...    app_package=com.android.settings    app_activity=com.android.settings.Settings
&{test_conf}    appium=&{appium}    drt=&{drt}
${start_appium}     appium  -p  &{test_conf['appium']}[port] --command-timeout 600 -r 5 --session-override --log-level info -g /tmp/appium.log &

*** Keyword ***
SSH Login
    [Arguments]     ${server}=&{test_conf['appium']}[server]   ${port}=&{test_conf['appium']}[sshport]     ${login}=bytonsqa    ${loginpwd}=test123!   ${alias}=ssh
    Open connection     ${server}       alias=${alias}       port=${port}
    Login       ${login}    ${loginpwd}
    Set Client Configuration    prompt=$

SSH Logout
    [Arguments]     ${alias}=ssh
    Switch Connection	${alias}
    Close Connection

Start Appium Service
    Import Library      platform 
    ${sy}=      platform.System
    Run Keyword If      '${sy}'=='Windows'    Start Appium Service Windows
    ...     ELSE        Start Appium Service Linux

Stop Appium Service
    Import Library      platform 
    ${sy}=      platform.System
    Run Keyword If      '${sy}'=='Windows'     Stop Appium Service Windows
    ...     ELSE      Stop Appium Service Linux

Connect ADB Device
    Import Library      platform 
    ${sy}=      platform.System
    Run Keyword If      '${sy}'=='Windows'     Connect ADB Device Windows
    ...     ELSE      Connect ADB Device Linux

Get ADB Device
    Import Library      platform 
    ${sy}=      platform.System
    Run Keyword If      '${sy}'=='Windows'     Get ADB Device Windows
    ...     ELSE      Get ADB Device Linux

Disconnect Adb Device
    Import Library      platform 
    ${sy}=      platform.System
    Run Keyword If      '${sy}'=='Windows'     Disconnect Adb Device Windows
    ...     ELSE      Disconnect Adb Device Linux

Get Screenshot From Android
    [Arguments]    ${spath}=.   ${display_id}=0    ${dev}=''
    Import Library      platform 
    ${sy}=      platform.System
    Run Keyword If      '${sy}'=='Windows'     Get Screenshot From Android Windows      ${spath}   ${display_id}    ${dev}
    ...     ELSE      Get Screenshot From Android Linux      ${spath}   ${display_id}    ${dev}

Start Appium Service Linux    
    Start Process   rm -rf nohup.out & rm -rf /tmp/appium.log       shell=True
    Start Process   ${start_appium}   shell=True
    :For    ${x}    IN RANGE    10
    \   ${output}=     Run Process    cat /tmp/appium.log       shell=True
    \   Log    ${output.stdout}     console=${True}
    \   BuiltIn.Sleep    5s
    \   ${m}=    Get Lines Containing String    ${output.stdout}   Appium REST http interface listener started on
    \   Exit For Loop if    len("${m}")>5

Stop Appium Service Linux
    Start Process       pkill -9 node & pkill -9 appium           shell=True  

Get ADB Device Linux
    ${output}=     Run Process    adb devices       shell=True
    @{count}=     Get Regexp Matches     ${output.stdout}       regexp=(?im)(\\w+)

Connect ADB Device Linux
    #Run Process     adb kill-server       shell=True
    Run Process     adb start-server           shell=True
    BuiltIn.Sleep   5s 
    Start Process     adb connect &{test_conf['drt']}[devudid]      shell=True
    Start Process     adb -s &{test_conf['drt']}[devudid] root      shell=True

Disconnect Adb Device Linux
    Run Process     adb kill-server     shell=True

Get Screenshot From Android Linux
    [Arguments]    ${spath}=.   ${display_id}=0    ${dev}=''
    ${output}=    Run Process     pwd       shell=True
    ${date}=        Get Current Date
    ${date}=        Convert Date     ${date}        %Y%m%d%H%M%S 
    Run Process    adb -s &{test_conf['drt']}[devudid] shell screencap -p -d ${display_id} /sdcard/${date}.png     shell=True
    Return From Keyword IF    "Unable to get handle" in "${output.stdout}"    ${False}
    Run Process    adb -s &{test_conf['drt']}[devudid] pull /sdcard/${date}.png "${spath}"     shell=True

Start Appium Service Windows
    [Documentation]
    ...    This keyword is used to start appium service on windows platform.
    ...    
    ...    *Examples:*
    ...    | Start Appium Service |
    #Stop Appium Service Windows
    Run Process    DEL    ${OUTPUT DIR}\\appium.log    shell=True
    Start Process    start   APPIUM Service    /i    appium    -a    &{test_conf['appium']}[server]    -p    &{test_conf['appium']}[port]
    ...    --log    ${OUTPUT DIR}\\appium.log    --log-timestamp    --local-timezone    shell=True    output_encoding=CONSOLE    alias=appium
    :For    ${x}    IN RANGE    10
    \   ${output}=    Run Process    type    ${OUTPUT DIR}\\appium.log    shell=True    output_encoding=CONSOLE
    \   Log    ${output.stdout}     console=${True}
    \   BuiltIn.Sleep    5s
    \   ${m}=    Get Lines Containing String    ${output.stdout}    Appium REST http interface listener started on
    \   Exit For Loop if    len("${m}")>5

Stop Appium Service Windows
    [Documentation]
    ...    This keyword is used to stop appium service on windows platform.
    ...    
    ...    *Examples:*
    ...    | Stop Appium Service |
    Run Process    taskkill    /im    node.exe    /F    /T    shell=True
    BuiltIn.Sleep    5s
    Run Process    taskkill    /F    /T    /FI    WINDOWTITLE eq APPIUM Service*    shell=True

Get Screenshot From Android Windows
    [Documentation]
    ...    This keyword is used to get screenshot from android.
    ...    
    ...    *Examples:*
    ...    | Get Screenshot From Android |
    [Arguments]    ${spath}=.    ${display_id}=0    ${dev}=''
    ${date}=        Get Current Date
    ${date}=        Convert Date     ${date}        %Y%m%d%H%M%S
    ${output}=    Run Process    adb -s &{test_conf['drt']}[devudid] shell screencap -p -d ${display_id} /sdcard/${date}.png    shell=True    output_encoding=CONSOLE
    Return From Keyword IF    "Unable to get handle" in "${output.stdout}"    ${False}
    Run Process    adb -s &{test_conf['drt']}[devudid] pull /sdcard/${date}.png "${spath}"    shell=True    output_encoding=CONSOLE

Get ADB Device Windows
    ${output}=    Run Process    adb devices     shell=True
    @{count}=     Get Regexp Matches     ${output.stdout}       regexp=(?im)(\\w+)

Connect ADB Device Windows
    #Run Process     adb kill-server     shell=True
    Run Process     adb start-server    shell=True
    BuiltIn.Sleep   5s
    Run Process     adb connect &{test_conf['drt']}[devudid]        shell=True
    Start Process     adb -s &{test_conf['drt']}[devudid] root       shell=True
    

Disconnect Adb Device Windows
    Run Process     adb     kill-server     shell=True


    