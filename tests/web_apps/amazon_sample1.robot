*** Settings ***
Documentation  This is basic info about the Web_App test cases
Library  SeleniumLibrary
Test Teardown   Run Keyword If Test Failed   Close Browser

*** Variables ***
${TextCheck}  Ferrari 458
${TestURL_Google}     https://www.google.com/
${TestURL_Yahoo}      https://www.yahoo.com/
${TestURL_herokuapp}     http://the-internet.herokuapp.com/
${SampleItem}         a-m-us a-aui_157141-c a-aui_158613-t1 a-aui_72554-c a-aui_dropdown_187959-c a-aui_pci_risk_banner_210084-c a-aui_perf_130093-c a-aui_tnr_v2_180836-c a-aui_ux_145937-c a-meter-animate

*** Test Cases ***
User opens a web-site
    [Documentation]  This is some basic info about the test
    [Tags]  Smoke  Acceptance  Regression   P0
#    Open Browser  ${TestURL_Google}  firefox
    Open browser  ${TestURL_Google}  chrome
    Go To   ${TestURL_Yahoo}
    Go Back
    Sleep  1
    Go To  http://www.amazon.com
#    wait until page contains  Your Amazon.com
    Input Text  id=twotabsearchtextbox  ${TextCheck}
    click button  class=nav-input
    wait until page contains  results for "${TextCheck}"
    click link  css=#result_C a.s-access-detail-page
    wait until page contains  Back to search results
    click button  id=add-to-cart-button
    wait until page contains  1 item added to Cart
    click link  Proceed to Checkout
    page should contain element  ap_signila_pagelet_title
    element text should be  ap_signila_pagelet_title  Sign In


Test page Add/Remove Elements
   [Documentation]  This is some basic info about the test
   [Tags]  P0
   Go To   ${url}
   Click Link       //*[@href='/add_remove_elements/']

Test page Basic Auth (user and pass: admin)
   [Documentation]  This is some basic info about the test
   [Tags]   Now  P0
#   Run Keyword  Begin Web Test
#    Open Browser  ${url}  ${browser}
   Go To   ${url}
   Click Link       xpath=//a[contains(text(),'Basic Auth')]
   Select WIndow  title=Sign in - Google Accounts #To select the new pop up window
   Input Text  id=username  username
   Input Text  id=pswd   pswd
   Click Button  id=signup

User opens a web-site
   [Documentation]  This is some basic info about the test
   [Tags]  P1
#    Open Browser  ${TestURL_Google}  firefox
   Open browser  ${TestURL_Google}  chrome
   Go To   ${TestURL_Yahoo}
   Go Back
   Sleep  1
   Go To  http://www.amazon.com
#    wait until page contains  Your Amazon.com
   Input Text  id=twotabsearchtextbox  ${TextCheck}
   click button  class=nav-input
   wait until page contains  results for "${TextCheck}"
   click link  css=#result_C a.s-access-detail-page
   wait until page contains  Back to search results
   click button  id=add-to-cart-button
   wait until page contains  1 item added to Cart
   click link  Proceed to Checkout
   page should contain element  ap_signila_pagelet_title
   element text should be  ap_signila_pagelet_title  Sign In

Xpath for robotframework
   Click Button     //button[.//text() = 'Save']
   WebElement saveButton =
   driver.findElement(By.xpath(".//button/span[text()='Save']")
   Element should become visible    xpath=//button/span[text()='Save']
   Click Button     xpath=//button/span[text()='Save']
   Click Element    xpath=//button/span[text()='Save']

*** Keywords ***




