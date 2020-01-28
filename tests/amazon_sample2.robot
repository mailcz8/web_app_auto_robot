*** Settings ***
Documentation  This is basic info about the amazon test cases
Library  SeleniumLibrary

*** Variables ***
${TestURL}      http://www.amazon.com
@{BrowzerType}   firefox     chrome

*** Test Cases ***
Test open browser to amazon
    Begin Web Test  http://www.amazon.com  firefox
    End Web Test

User opens amazon web-site 1 Smoke
    [Documentation]  This is some basic info about the test
    [Tags]  Smoke  Acceptance   P0
    open browser  ${TestURL}  @{BrowzerType}[1]
    sleep  2
    close browser

User opens amazon web-site acceptance
    [Documentation]  This is some basic info about the test
    [Tags]  Smoke  Acceptance   P1
    open browser  ${TestURL}  @{BrowzerType}[1]
    sleep  2
    close browser

User opens amazon web-site 2 Regression 1
    [Documentation]  Test for open browser 2nd time
    [Tags]  Regression      P3
    open browser  ${TestURL}  @{BrowzerType}[1]
    sleep  2
    close all browsers

User opens amazon web-site 3 Regression 2
    [Documentation]  Test for open browser 2nd time
    [Tags]  Regression
    open browser  ${TestURL}  @{BrowzerType}[1]
    sleep  2
    close all browsers

Test case 4
    [Documentation]  test case 4 title
    [Tags]  Functional  P4
    log to console  I am test case 1 of API feature

*** Keywords ***
Begin Web Test
    [Arguments]  ${url}  ${browser}
    open browser  ${url}  ${browser}

End Web Test
    close browser
