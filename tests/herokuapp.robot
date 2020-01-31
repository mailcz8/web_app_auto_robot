*** Settings ***
Documentation  This is basic info about the Byton test cases
Library  SeleniumLibrary
Suite Setup     Run Keyword And Ignore Error    Begin Web Test
Suite Teardown   Run Keyword And Ignore Error    End Web Test
#Test Setup      Run Keyword If Test Failed   Close Browser
#Test Teardown   Run Keyword If Test Failed   Close Browser

*** Variables ***
${TextCheck}  Ferrari 458
${TestURL_Google}     https://www.google.com/
${url}     http://the-internet.herokuapp.com/
${browser}        chrome
${SampleItem}         abc

*** Test Cases ***
Test open browser to ${url}
   [Documentation]  This is some basic info about the test
   [Tags]  Smoke  P0
#   Run Keyword  Begin Web Test
#    Open Browser  ${url}  ${browser}
   wait until page contains     Welcome to the-internet
#   End Web Test

Test Form Authentication Login Failed
   [Documentation]  This is some basic info about the test
   [Tags]   HeroDropdown        P0
#   Run Keyword  Begin Web Test
#    Open Browser  ${url}  ${browser}
   Go To   ${url}
   Click Link       //*[@href='/dropdown']
#   Run Keyword If pag AND '${Size}' == 'Small' AND '${Design}' != '${Simple}'      Check the quantity
#    ${c}=    Get Text      xpath://h2[contains(text(),'HeroDropdown')]
#    log to console      ${c}
    Page should contain       Dropdown List
    Click Element       xpath=//select[@id='dropdown']
    Click Element       xpath=//*[text()='Option 2']
    Sleep   3
#    ${Result}=  Page Should Contain Element   xpath=//*[@selected='selected' and text()='Option 2']
    ${Result}=  Get Element Attribute   xpath=//*[@selected='selected' and text()='Option 2']   for
    log to console       ${\n}${Result}
    log     ${\n}${Result}
#    ${beta}=  Get Element Value   xpath=//*[@selected='selected' and text()='Option 2']
#    log to console       ${\n}${beta}
#    log     ${\n}${beta}
#    Run Keyword Unless  '${RESULT}'=='PASS'  Keyword args*
#    Run Keyword If   ${c}'=='A/B Test Control' OR '${c}'=='A/B Test Variation 1'    Go Back
#    Wait until page contains   Your username is invalid!

Test Form Authentication Login Failed
   [Documentation]  This is some basic info about the test
   [Tags]   P0
#   Run Keyword  Begin Web Test
#    Open Browser  ${url}  ${browser}
   Go To   ${url}
   Click Link       //*[@href='/login']
#   Run Keyword If pag AND '${Size}' == 'Small' AND '${Design}' != '${Simple}'      Check the quantity
    ${c}=    Get Text      xpath://h2[contains(text(),'Login Page')]
    log to console      ${c}
#    Click button      xpath://*[@class='fa fa-2x fa-sign-in']
    Click button      css:#login > button
#    Click button      class:'fa fa-2x fa-sign-in'
#    Run Keyword If   ${c}'=='A/B Test Control' OR '${c}'=='A/B Test Variation 1'    Go Back
    Wait until page contains   Your username is invalid!


Test Form Authentication Login Pass
   [Documentation]  This is some basic info about the test
   [Tags]   P0
#   Run Keyword  Begin Web Test
#    Open Browser  ${url}  ${browser}
   Go To   ${url}
   Click Link       //*[@href='/login']
#   Run Keyword If pag AND '${Size}' == 'Small' AND '${Design}' != '${Simple}'      Check the quantity
    ${c}=    Get Text      xpath://h2[contains(text(),'Login Page')]
    log to console      ${c}
#    Click button      xpath://*[@class='fa fa-2x fa-sign-in']
    Input Text        id:username       tomsmith
#    Click Element     id:passowr
    Input Password    id:password       SuperSecretPassword!
    Click button      css:#login > button
#    Click button      class:'fa fa-2x fa-sign-in'
#    Run Keyword If   ${c}'=='A/B Test Control' OR '${c}'=='A/B Test Variation 1'    Go Back
    Wait until page contains   You logged into a secure area!


Test page A/B Testing
   [Documentation]  This is some basic info about the test
   [Tags]  Smoke  P0
#   Run Keyword  Begin Web Test
#    Open Browser  ${url}  ${browser}
   Go To   ${url}
   Click Link       //*[@href='/abtest']
#   Run Keyword If pag AND '${Size}' == 'Small' AND '${Design}' != '${Simple}'      Check the quantity
    ${c}    Get Text      xpath://h2[contains(text(),'A/B Test')]
    log to console   ${c}
#    Run Keyword If   ${c}'=='A/B Test Control' OR '${c}'=='A/B Test Variation 1'    Go Back
   Wait until page contains  ${c}
   Go Back


*** Keywords ***
Begin Web Test
#    [Arguments]  ${url}  ${browser}
   open browser  ${url}  ${browser}

End Web Test
   close browser