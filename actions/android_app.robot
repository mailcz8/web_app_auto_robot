*** Settings ***
Library     DateTime
#Library     AsyncKeyword
Resource    appium_libs.robot
Library     platform
Library     Collections
#Library     Image

*** Variable ***
${oper_delay}    6s
${remote_url}   http://&{test_conf['appium']}[server]:&{test_conf['appium']}[port]/wd/hub
&{desire_cap}   platformName=Android    platformVersion=&{test_conf['main_device_id']}[android_ver]
...    automationName=uiautomator2    deviceName=&{test_conf['main_device_id']}[devname]    newCommandTimeout=600    
...    appPackage=&{test_conf['main_device_id']}[app_package]    appActivity=&{test_conf['main_device_id']}[app_activity]
...    noSign=${True}    noReset=${True}    dontStopAppOnReset=${True}    unicodeKeyboard=${False}    resetKeyboard=${True}    alias=BaiduMap
...    appWaitDuration=90000       printPageSourceOnFindFailure=${True}
&{main_device_id}      app=com.baidu.naviauto      appAct=com.baidu.naviauto.NaviAutoActivity
&{voiceassistant}      app=com.baidu.che.codriver      appAct=com.baidu.che.codriver.ui.MainActivity
${split_button}    com.amazon.launcher:id/split_button

*** Test Cases ***
Print Log Now
    [Tags]  P0
    log to console     ${\n}line oper_delay:${oper_delay}
    log      ${\n}line oper_delay:${oper_delay}
    log to console     ${\n}line remote_url:${remote_url}
    log      ${\n}line remote_url:${remote_url}
    log to console     ${\n}line desire_cap:&{desire_cap}
    log to console     ${\n}line main_device_id:&{main_device_id}
    log to console     ${\n}line voiceassistant:&{voiceassistant}
    log to console     ${\n}line split_button:${split_button}


*** Keyword ***
Start App
    [Documentation]
    ...    This keyword is used to open App on android.
    ...    
    ...    *Examples:*
    ...    | Start App |
    ${s}=       Run Keyword and Return Status   AppiumLibrary.Open Application        ${remote_url}       alias=&{desire_cap}[alias]       &{desire_cap} 
    Run Keyword IF      ${s}==${False}      Start ADB Command       adb -s &{test_conf['main_device_id']}[devudid] shell pm clear com.android.settings 
    Run Keyword IF      ${s}==${False}      AppiumLibrary.Open Application        ${remote_url}       alias=&{desire_cap}[alias]       &{desire_cap} 

Close BaiduMap
    [Documentation]
    ...    This keyword is used to close main_device_id on android.
    ...    
    ...    *Examples:*
    ...    | Close DT |
    #Switch Application    BaiduMap
    #Quit Application
    Start ADB Command    adb -s &{test_conf['main_device_id']}[devudid] shell am force-stop &{main_device_id}[app]

Click Split_Mode Toggle
    [Documentation]    
    ...    This keyword is used to click Split_Mode Toggle
    ...    
    ...    *Examples:*
    ...    | Click Split_Mode Toggle |
    Wait Until Page Contains Element    id=${split_button}
    Click Button    id=${split_button}

Enable Split Mode
    ${app}=     Get SED Left App
    Run Keyword If  '${app}'=="no found app on left sed"      Click Split_Mode Toggle

Disable Split Mode
    ${app}=     Get SED Left App
    Run Keyword If  '${app}'!='no found app on left sed'      Click Split_Mode Toggle

Click Button
    [Documentation]
    ...    This keyword is used on click button by resource-id
    ...    
    ...    *Examples:*
    ...    | Click Button | id=${ivalue} |
    [Arguments]     ${ivalue}
    Click Element       ${ivalue}
    Sleep   0.5

Click Element By Xpath
    [Documentation]
    ...    This keyword is used on click button by Xpath
    ...    
    ...    *Examples:*
    ...    | Click Element By Xpath | 我的 |
    [Arguments]     ${xvalue}
    ${els}      Get Webelements    xpath=${xvalue}
    :FOR  ${el}  IN  @{els}
    \   ${vis}=     Element Should Be Visible       ${el}
    \   Exit For Loop if    ${vis}==${NONE}
    Click Element       ${el}     

Click Element By Text
    [Documentation]
    ...    This keyword is used on click button by text
    ...    
    ...    *Examples:*
    ...    | Click Element | 我的 |
    [Arguments]    ${txt}    ${index}=0
    ${els}      Get Webelements    android=new UiSelector().text("${txt}").index(${index})
    :FOR  ${el}  IN  @{els}
    \   ${vis}=     Element Should Be Visible       ${el}
    \   Exit For Loop if    ${vis}==${NONE}
    Click Element       ${el}

Get Element Text By Text
    [Documentation]
    ...    This keyword is used on get button text that have same level node can be identified by text
    ...    
    ...    *Examples:*
    ...    | Get Element By Text | 我的 |
    [Arguments]    ${txt}    ${index}=0
    ${r}    AppiumLibrary.Get Text    android=new UiSelector().text("${txt}").index(${index})
    [Return]    ${r}

Get Element Text
    [Documentation]
    ...    This keyword is used on get text from the locator
    ...    
    ...    *Examples:*
    ...    | Get Element Text | id=com.amazon.ice.multimedia:id/test |
    [Arguments]    ${locator}
    ${r}    AppiumLibrary.Get Element Attribute    ${locator}       text
    [Return]    ${r}

Input Text
    [Documentation]
    ...      This keyword is used to input text to 
    ...    
    ...    *Examples:*
    ...    | Input Text | 我的 |   
    [Arguments]     ${args}      ${text}
    AppiumLibrary.input text        ${args}    ${text}

Open Baidu Map
    [Documentation]    
    ...    This keyword is used to open Baidu Map on main_device_id
    ...    
    ...    *Examples:*
    ...    | Open Baidu Map |
    Run Keyword And Ignore Error       launch application
    Run Keyword And Ignore Error       Start Activity    &{main_device_id}[app]    &{main_device_id}[appAct]        intentAction=android.intent.action.MAIN    intentCategory=android.intent.category.LAUNCHER    intentFlags=0x10200000


Open Ximalaya
    ${s}=       Run Keyword and Return Status   Start Activity   com.amazon.ice.android.multimedia    com.amazon.ice.android.multimedia.ui.main.SEDDisplayActivity    appWaitActivity=com.amazon.ice.android.multimedia.ui.main.*        intentAction=android.intent.action.MAIN    intentCategory=android.intent.category.LAUNCHER    intentFlags=0x10200000
    Run Keyword IF      ${s}==${False}      Start Activity   com.amazon.ice.android.multimedia    com.amazon.ice.android.multimedia.ui.main.SEDDisplayActivity    appWaitActivity=com.amazon.ice.android.multimedia.ui.main.*        intentAction=android.intent.action.MAIN    intentCategory=android.intent.category.LAUNCHER    intentFlags=0x10200000

Open dianping
    ${s}=       Run Keyword and Return Status   Start Activity   com.amazon.ice.dianping    com.amazon.ice.dianping.ui.LoadingActivity    appWaitActivity=com.amazon.ice.ui.*       intentAction=android.intent.action.MAIN    intentCategory=android.intent.category.LAUNCHER    intentFlags=0x10200000
    Run Keyword IF      ${s}==${False}      Start Activity   com.amazon.ice.dianping    com.amazon.ice.dianping.ui.LoadingActivity    appWaitActivity=com.amazon.ice.ui.*        intentAction=android.intent.action.MAIN    intentCategory=android.intent.category.LAUNCHER    intentFlags=0x10200000

Launch Nav App
    [Documentation]
    ...    This keyword is used to launch Navigation app from main_device_id and have SED display map
    ...
    ...    *Examples:*
    ...    | Launch Nav App |
    Start ADB Command      adb -s &{test_conf['main_device_id']}[devudid] shell am start -n "&{main_device_id}[app]/&{main_device_id}[appAct]" --display 6
    Run Keyword And Ignore Error    Bypass Init Screen
    Sleep   5s
    Bypass Battery Low Popup

Bypass Battery Low Popup
    ${s} =      BuiltIn.Run Keyword And Return Status   Page Should Contain Text        知道了
    Run Keyword IF      ${s}==${True}         Click Text       知道了

Clear Map Data
    Start ADB Command      adb -s &{test_conf['main_device_id']}[devudid] shell pm clear com.baidu.naviauto

Grant Android Permission
    [Arguments]     ${pkg}
    Start ADB Command      adb -s &{test_conf['main_device_id']}[devudid] shell pm grant ${pkg} android.permission.ACCESS_FINE_LOCATION
    Start ADB Command      adb -s &{test_conf['main_device_id']}[devudid] shell pm grant ${pkg} android.permission.READ_EXTERNAL_STORAGE
    Start ADB Command      adb -s &{test_conf['main_device_id']}[devudid] shell pm grant ${pkg} android.permission.ACCESS_COARSE_LOCATION
    Start ADB Command      adb -s &{test_conf['main_device_id']}[devudid] shell pm grant ${pkg} android.permission.READ_PHONE_STATE
    Start ADB Command      adb -s &{test_conf['main_device_id']}[devudid] shell pm grant ${pkg} android.permission.CALL_PHONE
    Start ADB Command      adb -s &{test_conf['main_device_id']}[devudid] shell pm grant ${pkg} android.permission.PROCESS_OUTGOING_CALLS
    Start ADB Command      adb -s &{test_conf['main_device_id']}[devudid] shell pm grant ${pkg} android.permission.WRITE_EXTERNAL_STORAGE

Set Battery Level
    [Arguments]     ${battery_level}
    Start ADB Command      adb -s &{test_conf['main_device_id']}[devudid] shell am broadcast -a com.amazon.nav.setting --es battery_percentage ${battery_level}

Bypass Init Screen
    :For    ${i}    IN RANGE     5
    \        ${s} =  Run Keyword And Return Status    Wait Until Page Contains     ALLOW     3s
    \        Run Keyword IF      ${s}==${True}        Log to Console    "Bypass the allow location permission screen..."
    \        Run Keyword IF      ${s}==${True}        Click Text        ALLOW
    \        Run Keyword IF      ${s}==${True}    Sleep    2s   
    \        Run Keyword If    ${s}==${False}         Log To Console    "Permission of location is already granted."
    \        Exit For Loop if  ${s}==${False}   
        
Open Voice Assistant
    [Documentation]    
    ...    This keyword is used to open Voice Assistant on main_device_id
    ...    
    ...    *Examples:*
    ...    | Open Voice Assistant |
    Run Keyword And Ignore Error       Start Activity    &{voiceassistant}[app]    &{voiceassistant}[appAct]        intentAction=android.intent.action.MAIN    intentCategory=android.intent.category.LAUNCHER    intentFlags=0x10000000
    Run Keyword And Ignore Error       Start Activity    &{voiceassistant}[app]    &{voiceassistant}[appAct]        intentAction=android.intent.action.MAIN    intentCategory=android.intent.category.LAUNCHER    intentFlags=0x10000000

Restart Voice Assistant
    [Documentation]
    ...    This keyword is used to restart Voice Assistant on main_device_id
    ...    
    ...    *Examples:*
    ...    | Open Voice Assistant |
    Start Adb Command       adb -s &{test_conf['main_device_id']}[devudid] shell am force-stop &{voiceassistant}[app]
    Sleep       5s
    Log     Restart the Duros as it has an issue cause sed not display on the front

Open amazon Launcher
    [Documentation]    
    ...    This keyword is used to open Voice Assistant on main_device_id
    ...    
    ...    *Examples:*
    ...    | Open amazon Launcher |

Get SED ScreenShot
    [Arguments]     ${sc_name}=""
    [Documentation]    
    ...    This keyword is used to screenshot on SED
    ...    
    ...    *Examples:*
    ...    | Get SED ScreenShot |
    ${date}=        Get Current Date
    ${date}=        Convert Date     ${date}        %Y%m%d%H%M%S
    ${sc_name}=     Run Keyword If     '${sc_name}'=='""'   Set Variable    ${date}
    ...     ELSE    Set Variable    ${sc_name}
    Get Screenshot From Android    ${OUTPUT DIR}/${sc_name}_sed.png    6
    Log     <img src="${sc_name}_sed.png">    html=yes
    [return]    ${OUTPUT DIR}/${sc_name}_sed.png

Get SED Text
    [Arguments]     ${pixel}='${NONE}'
    ${fl}=      Get SED ScreenShot
    ${txt}=     Recognize Txt       ${fl}   ${pixel} 
    Remove File     ${fl}
    [return]      ${txt}

Get main_device_id ScreenShot
    [Arguments]     ${sc_name}=""
    [Documentation] 
    ...    This keyword is used to screenshot on main_device_id
    ...    
    ...    *Examples:*
    ...    | Get main_device_id ScreenShot |
    ${date}=        Get Current Date
    ${date}=        Convert Date     ${date}        %Y%m%d%H%M%S
    ${sc_name}=     Run Keyword If     '${sc_name}'=='""'   Set Variable    ${date}
    ...     ELSE    Set Variable    ${sc_name}
    Get Screenshot From Android    ${OUTPUT DIR}/${sc_name}_main_device_id.png    1
    Log     <img src="${sc_name}_main_device_id.png">    html=yes
    [return]    ${OUTPUT DIR}/${sc_name}_main_device_id.png

Swipe To Middle
    Swipe To Bottom
    ${status}    ${value}=    Run Keyword And Ignore Error    Swipe By Percent    50    30   50    65
    Run Keyword If    '${status}' != 'PASS'    Run Keyword And Ignore Error    Swipe By Percent    50    30   50    65

Swipe To Bottom
    :For    ${i}    IN RANGE    3
    \    ${status}    ${value}=    Run Keyword And Ignore Error    Swipe By Percent    60    90   60    30
    \    Run Keyword If    '${status}' != 'PASS'    Run Keyword And Ignore Error    Swipe By Percent    60    90   60    30

Swipe To Top
    :For    ${i}    IN RANGE    3
    \    ${status}    ${value}=    Run Keyword And Ignore Error    Swipe By Percent    50    30   50    90      
    \    Run Keyword If    '${status}' != 'PASS'    Run Keyword And Ignore Error    Swipe By Percent    50    30   50    90

Click Home Button
    [Documentation]    
    ...    This keyword is used to click Home button
    ...    
    ...    *Examples:*
    ...    | Click Home Button |
    Start Adb Command       adb -s &{test_conf['main_device_id']}[devudid] shell input keyevent 3

Click Quick Access
    [Documentation]    
    ...    This keyword is used to click Quick Access
    ...    
    ...    *Examples:*
    ...    | Click Quick Access |
    Swipe By Percent        50      1       50      95    3000

Close Quick Access
    [Documentation]    
    ...    This keyword is used to click Quick Access
    ...    
    ...    *Examples:*
    ...    | Click Quick Access |
    Swipe By Percent        50      99       50      1    3000

Set Default IME
    [Documentation]    
    ...    This keyword is used to set default ime
    ...    
    ...    *Examples:*
    ...    | Set Default IME |
    [Arguments]     ${ime}=com.sinovoice.hcicloudinputvehicle/.service.HciCloudIME
    Start ADB Command       adb -s &{test_conf['main_device_id']}[devudid] shell settings put secure default_input_method ${ime}

Start ADB Command
    [Arguments]     ${cmd}
    [Documentation]    
    ...    This keyword is execute adb commands
    ...    
    ...    *Examples:*
    ...    | Start ADB Command |    adb -s &{test_conf['main_device_id']}[devudid] shell input keyevent 3
    ${sy}=      platform.System
    Log     ${cmd}      console=${True} 
    Run Keyword If      '${sy}'=='Windows'    Run Keyword and Return      Start ADB Command Windows     ${cmd}
    ...     ELSE        Run Keyword and Return     Start Adb Command Linux     ${cmd}

Start ADB Command Windows
    [Arguments]     ${cmd}
    ${cmd}=      Replace String    ${cmd}     grep       findstr
    ${stdout}=      Run Process     ${cmd}      shell=True    output_encoding=CONSOLE       alias=adb      stdout=${OUTPUT DIR}/adb_command
    [return]    ${stdout.stdout}

Start Adb Command Linux
    [Arguments]     ${cmd}
    ${stdout}=    Run Process     ${cmd}      shell=True    output_encoding=CONSOLE       alias=adb      stdout=${OUTPUT DIR}/adb_command 
    [return]     ${stdout.stdout}
    
Stop App
    [Arguments]     ${app}
    [Documentation]    
    ...    This keyword is used to click Home button
    ...    
    ...    *Examples:*
    ...    | Click Home Button |
    Start ADB Command       adb -s &{test_conf['main_device_id']}[devudid] shell am force-stop ${app}

Get Current App
    [Documentation]    
    ...    This keyword is used to click Get preset App
    ...    
    ...    *Examples:*
    ...    ${ret}   | Get Current App |
    ${output}=      Start Adb Command       adb -s &{test_conf['main_device_id']}[devudid] shell dumpsys window | grep "mCurrentFocus"
    [return]    ${output}

Check Current App
    [Documentation]
    [Arguments]     ${preApp}=com.baidu.naviauto
    ${app}=     Get Current App
    ${app}      Split String    ${app}      /
    Should Contain      ${app[0]}      ${preApp}

main_device_id Should Exist App
    [Arguments]     ${app}
    ${apps}=     Get Current App
    ${apps}      Split String    ${apps}      /
    Should Contain      ${apps[0]}      ${app}

main_device_id Should Not Exist App
    [Arguments]     ${app}
    ${apps}=     Get Current App
    ${apps}      Split String    ${apps}      /
    Should Not Contain      ${apps[0]}      ${app}

Check Present Voice Assistant App
    [Arguments]     ${result}=${True}
    ${stdout}=      Start Adb Command      adb -s &{test_conf['main_device_id']}[devudid] shell dumpsys window windows | grep Surface:.*101000
    ${re}=      Run Keyword And Return Status      Should Contain      ${stdout}    true
    Should Be Equal      ${re}      ${result}

Get Current App On SED
    ${stdout}=      Start Adb Command      adb -s &{test_conf['main_device_id']}[devudid] shell dumpsys window windows
    ${ls}=      Split String        ${stdout}       Window${SPACE}
    ${packs}=        Create List     
    :FOR  ${e}  IN  @{ls}
    \   ${pack}=     Get Regexp Matches     ${e}         \\d+\\s+Window{\\S+\\s+\\S+\\s+\(\\S+.*\)}\\:      1     
    \   ${res}=     Run Keyword And Ignore Error        Should Contain     ${e}     Surface: shown=true
    \   Run Keyword If      '${res[0]}'=='PASS'      Append To List     ${packs}        ${pack}    
    [Return]    ${packs}

Check Current App On SED
    [Arguments]     ${pack}
    ${packs}=       Get Current App On SED
    FOR  ${element}  IN  @{packs}
        ${res}=     Run Keyword And Ignore Error        Should Contain     ${element[0]}        ${pack}
        ${ret}=     Run Keyword If     '${res[0]}'=='PASS'     Set Variable      ${True}
        ...         ELSE        Set Variable        ${False}
        Exit For Loop If      '${res[0]}'=='PASS' 
    END
    [Return]        ${ret}

SED Should Exist App
    [Arguments]     ${pack}
    ${ret}=     Check Current App On SED  ${pack}
    Should Be True      ${ret}      we expect ${pack} exist on the sed, but failed

SED Should Not Exist App
    [Arguments]     ${pack}
    ${ret}=     Check Current App On SED  ${pack}
    Should Not Be True      ${ret}      we expect ${pack} not exist on the sed, but failed

Get SED Left App
    ${stdout}=      Start Adb Command      adb -s &{test_conf['main_device_id']}[devudid] shell dumpsys window windows
    ${ls}=      Split String        ${stdout}       Window${SPACE}
    FOR  ${e}  IN  @{ls}
        Log      ${e}
        ${pack}=     Get Regexp Matches     ${e}         \\d+\\s+Window{\\S+\\s+\\S+\\s+\(\\S+.*\)}\\:      1  
        ${disp}=     Run Keyword And Ignore Error   Get Regexp Matches     ${e}         display\=\\[\(\\d+\),\\d+\\]\\[\(\\d+\),\\d+\\]\\s+overscan\=\\[\(\\d+\),\\d+\\]\\[\(\\d+\),\\d+\\]      1     2   3   4
        ${disp}=    Set Variable    ${disp[1]}
        ${h}=   Run Keyword And Ignore Error    Evaluate      (int(@{disp[0]}[3])-int(@{disp[0]}[2]))/(int(@{disp[0]}[1])-int(@{disp[0]}[0]))
        ${res}=     Run Keyword And Ignore Error        Should Contain     ${e}     Surface: shown=true
        ${app}      Set Variable    no found app on left sed
        Continue For Loop If    "${h[0]}"=="FAIL"
        ${app}=     Run Keyword If     '${h[1]}'=='2.0' and '${res[0]}'=='PASS'     Set Variable    ${pack[0]}
        ...                 ELSE    Set Variable    no found app on left sed
        Exit For Loop If    "${app}" != 'no found app on left sed'
    END
    [return]    ${app}

Get SED Right App
    ${stdout}=      Start Adb Command      adb -s &{test_conf['main_device_id']}[devudid] shell dumpsys window windows
    ${ls}=      Split String        ${stdout}       Window${SPACE}  
    FOR  ${e}  IN  @{ls}
        Log      ${e}
        ${pack}=     Get Regexp Matches     ${e}         \\d+\\s+Window{\\S+\\s+\\S+\\s+\(\\S+.*\)}\\:      1  
        ${disp}=     Run Keyword And Ignore Error   Get Regexp Matches     ${e}         display\=\\[\(\\d+\),\\d+\\]\\[\(\\d+\),\\d+\\]\\s+overscan\=\\[\(\\d+\),\\d+\\]\\[\(\\d+\),\\d+\\]      1     2   3   4
        ${disp}=    Set Variable    ${disp[1]}
        ${h}=   Run Keyword And Ignore Error    Evaluate      (int(@{disp[0]}[3])-int(@{disp[0]}[2]))/(int(@{disp[0]}[1])-int(@{disp[0]}[0]))
        ${v}=   Run Keyword And Ignore Error    Evaluate       (int(@{disp[0]}[0])-int(@{disp[0]}[2]))!=0
        ${res}=     Run Keyword And Ignore Error        Should Contain     ${e}     Surface: shown=true
        ${app}      Set Variable    no found app on right sed
        Continue For Loop If    "${h[0]}"=="FAIL"
        ${app}=     Run Keyword If     '${h[1]}'=='2.0' and '${res[0]}'=='PASS' and '${v[1]}'=='True'     Set Variable    ${pack[0]}
        ...                 ELSE    Set Variable    no found app on right sed 
        Exit For Loop If    "${app}" != 'no found app on right sed'
    END
    [return]    ${app}

SED Left Should Exist App
    [Arguments]     ${app}
    ${packs}=       Get SED Left App
    Should Contain  ${packs}    ${app}      msg=we expect ${app} exist on the left sed, but failed,we got ${packs}

SED Left Should Not Exist App
    [Arguments]     ${app}
    ${packs}=       Get SED Left App
    Should Not Contain  ${packs}    ${app}      msg=we expect ${app} not exist on the left sed, but failed,we got ${packs}

SED Right Should Exist App
    [Arguments]     ${app}
    ${packs}=       Get SED Right App
    Should Contain  ${packs}    ${app}      msg=we expect ${app} exist on the right sed, but failed,we got ${packs}

SED Right Should Not Exist App
    [Arguments]     ${app}
    ${packs}=       Get SED Right App
    Should Not Contain  ${packs}    ${app}      msg=we expect ${app} not exist on the right sed, but failed,we got ${packs}

Get Installed App
    [Arguments]     ${grp}=amazon
    [Documentation]
    ...     This keyword is used to list all preinstalled app
    ...
    ...    *Examples:*
    ...    ${ret}   | Get Installed App |
    ${stdout}=      Start Adb Command       adb -s &{test_conf['main_device_id']}[devudid] shell pm list package |grep "${grp}"
    [return]    ${stdout}

Check Installed App
    [Arguments]     ${grp}=amazon
    [Documentation]
    ...     This keyword is used to check preinstalled app
    ...
    ...    *Examples:*
    ...    ${ret}   | Check Installed App |
    ${preapp}=      Get Installed App       ${grp}
    Should Not Be Empty     ${preapp}   we expect ${grp} installed on build, but failed,we got ${preapp}
    
Three Fingers Touch
    [Documentation]
    ...     This keyword is used to touch with three fingers
    ...
    ...    *Examples:*
    ...    ${ret}   | Check Installed App |
    Swipe Multi Touch

Zoom In
    [Arguments]     ${steps}=1
    [Documentation] 
    ...     This keyword is used to Zoom In view
    ...
    ...    *Examples:*
    ...    | Zoom In |  1
    Zoom    steps=${steps}

Zoom Out
    [Arguments]     ${steps}=1
    [Documentation] 
    ...     This keyword is used to Zoom out view
    ...
    ...    *Examples:*
    ...    | Zoom out |  2
    Pinch   steps=${steps}

Double Click
    [Arguments]     ${ele}
    [Documentation] 
    ...     This keyword is use to double click on element
    ...
    ...    *Examples:*
    ...    | Double Click |  id=${navigation_panel}
    Tap    locator=${ele}   count=2

Two Fingers Click
    [Documentation]
    ...     This keyword is used to perform single click with two fingers
    ...
    ...    *Examples:*
    ...    ${ret}   | Check Installed App |
    Click Multi Touch

Pan Map
    [Documentation]
    ...     This keyword is used to perform click and hold to drag the map to a new place with two fingers.
    ...
    ...    *Examples:*
    ...    ${ret}   | Check Installed App |
    Drag Multi Touch

Click Bottom Home
    [Documentation]
    ...     This keyword is used to click Home button
    ...    pre step
    ...     Connect main_device_id     android:///&{test_conf['main_device_id']}[devudid]?cap_method=adbcap&touch_method=minitouch
    ...     Set Airtest Snaps Dir       ${EXECDIR}/res/screenshot/launcher/main_device_id     dir_type=main_device_id
    ...     Set Airtest Log Dir     ${OUTPUT DIR}/screen_launcher
    ...    *Examples:*
    ...    | Click Bottom Home |
    Run Keyword And Ignore Error        Touch On main_device_id        launcher_home.png

Logcat Should Exist Log
    [Arguments]     ${log}      ${filter}="."       ${alias}=logcat     ${line}=2000
    [Documentation]
    ...     This keyword is used to check logcat logs on /data/vendor/amazonlogs/logcat_log
    ...
    ...    *Examples:*
    ...    |  Logcat Should Exist Log     |  get DrivingMode:ECO  |
    ${r}=   Start ADB Command       adb -s &{test_conf['main_device_id']}[devudid] shell tail -n ${line} /data/vendor/amazonlogs/logcat_log | grep -i ${filter}
    ${ch_list}=       Run Keyword And Ignore Error    Should be String        ${log}
    ${log_list}=   Run Keyword If      '${ch_list[0]}'!='PASS'     Convert To List     ${log}
    ...     ELSE      Set Variable    ${log}
    :FOR  ${l}  IN  ${log_list}
    \       Should Contain      ${r}    ${l}

Logcat Should Not Exist Log
    [Arguments]     ${log}      ${filter}="."   ${alias}=logcat     ${line}=2000
    [Documentation]
    ...     This keyword is used to check logcat logs NOT on /data/vendor/amazonlogs/logcat_log
    ...
    ...    *Examples:*
    ...    |  Logcat Should Not Exist Log     |  get DrivingMode:ECO  |
    ${r}=   Start ADB Command       adb -s &{test_conf['main_device_id']}[devudid] shell tail -n ${line} /data/vendor/amazonlogs/logcat_log | grep -i ${filter}
    ${ch_list}=       Run Keyword And Ignore Error    Should be String        ${log}
    ${log_list}=   Run Keyword If      '${ch_list[0]}'!='PASS'     Convert To List     ${log}
    ...     ELSE      Set Variable    ${log}
    :FOR  ${l}  IN  ${log_list}
    \       Should Not Contain      ${r}    ${l}

Check Logcat Log
    [Arguments]     ${log}      ${filter}="."       ${alias}=logcat     ${line}=2000         ${exp}=${True}
    ${r}=       Evaluate    "=" in '"${exp}"'
    ${exp}=      Run Keyword If      ${r}==${True}           Evaluate    ${exp}
    ...     ELSE       Set Variable     ${exp}
    Sleep   3s
    Run Keyword If      ${exp}==${True}     Logcat Should Exist Log     ${log}     ${filter}      ${alias}     ${line}
    ...     ELSE        Logcat Should Not Exist Log     ${log}     ${filter}      ${alias}     ${line}   
